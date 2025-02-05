/// Headers
///
enum Headers {
  client(label: 'Client'),
  status(label: 'Statut'),
  store(label: 'Magasin'),
  startDate(label: 'Date début'),
  endDate(label: 'Date fin'),
  price(
    label: 'Montant',
    isNumeric: true,
  ),
  commission(
    label: 'Commission',
    isNumeric: true,
  ),
  pinned(label: ''),
  actions(label: '');

  /// Constructor
  ///
  const Headers({
    required this.label,
    this.isNumeric = false,
  });

  final String label;
  final bool isNumeric;
}
