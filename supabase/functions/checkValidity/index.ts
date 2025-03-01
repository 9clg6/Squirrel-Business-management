// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

// Setup type definitions for built-in Supabase Runtime APIs
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

console.log("CheckValidity function initialized");

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey",
};

async function getLicenseDoc(licenseKey: string, supabaseClient: any) {
  const { data, error } = await supabaseClient
    .from("users")
    .select("*")
    .eq("id", licenseKey)
    .single();

  console.log("Données récupérées:", data);
  console.error("Erreur lors de la récupération de la licence:", error);

  if (error) {
    return null;
  }

  return data;
}

async function isLicenseValid(doc: any) {
  if (!doc) {
    return { valid: false, expirationDate: null };
  }

  const expirationDate = new Date(doc.expiration_date);
  console.log("Date d'expiration:", expirationDate);

  // Récupérer la date actuelle sans l'heure
  const today = new Date();
  const currentDate = new Date(
    today.getFullYear(),
    today.getMonth(),
    today.getDate()
  );

  // Récupérer la date d'expiration sans l'heure
  const expDate = new Date(
    expirationDate.getFullYear(),
    expirationDate.getMonth(),
    expirationDate.getDate()
  );

  if (expDate < currentDate) {
    console.log("Clé expirée");
    return { valid: false, expirationDate };
  }

  return { valid: true, expirationDate };
}

Deno.serve(async (req) => {
  try {
    // Create a Supabase client with the Auth context of the logged in user.
    const supabaseClient = createClient(
      // Supabase API URL - env var exported by default.
      Deno.env.get("SUPABASE_URL") ?? "",
      // Supabase API ANON KEY - env var exported by default.
      Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ?? "",
      // Create client with Auth context of the user that called the function.
      // This way your row-level-security (RLS) policies are applied.
      {
        global: {
          headers: { Authorization: req.headers.get("Authorization")! },
        },
      }
    );

    // Récupérer les données de la requête
    const { licenseKey } = await req.json();

    console.log("Clé de licence fournie:", licenseKey);

    if (!licenseKey) {
      return new Response(
        JSON.stringify({ error: "La clé de licence est manquante" }),
        { status: 400, headers: { "Content-Type": "application/json" } }
      );
    }

    // Vérifier la validité de la licence
    const doc = await getLicenseDoc(licenseKey, supabaseClient);
    console.log("Document récupéré:", doc);
    const { valid, expirationDate } = await isLicenseValid(doc);
    console.log("Vérification de la validité:", { valid, expirationDate });

    // Retourner le résultat
    console.log("Retour:", {
      valid,
      expirationDate: expirationDate ? expirationDate.toISOString() : null,
      licenseKey: licenseKey,
    });

    return new Response(
      JSON.stringify({
        valid,
        expirationDate: expirationDate ? expirationDate.toISOString() : null,
        licenseKey: licenseKey,
      }),
      { headers: { "Content-Type": "application/json" } }
    );
  } catch (error) {
    console.error("Erreur:", error);
    return new Response(
      JSON.stringify({
        error: "Erreur lors de la vérification de la clé de licence",
      }),
      { status: 500, headers: { "Content-Type": "application/json" } }
    );
  }
});

/* Pour invoquer localement:

  1. Exécutez `supabase start` (voir: https://supabase.com/docs/reference/cli/supabase-start)
  2. Faites une requête HTTP:

  curl -i --location --request POST 'http://127.0.0.1:54321/functions/v1/checkValidity' \
    --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0' \
    --header 'Content-Type: application/json' \
    --data '{"licenseKey":"votre-clé-de-licence"}'

*/
