/// Storage to manage secret data securely locally
abstract class StorageInterface<T> {
  /// Get all values from secure storage
  ///
  Future<List<T>> getAll();

  /// Get a string value from secure storage
  /// @param [key] the key to get the value from
  /// @return [Future<T>] the value
  ///
  Future<T> get(String key);

  /// Set a string value in secure storage
  /// @param [key] the key to set the value to
  /// @param [value] the value to set
  /// @return [Future<void>]
  ///
  Future<void> set(String key, String value);

  /// Remove a string value from secure storage
  /// @param [key] the key to remove the value from
  /// @return [Future<void>]
  ///
  Future<void> remove(String key);

  /// Check if the storage contains [key]
  /// @param [key] the key to check if it exists
  /// @return [Future<bool>] true if the storage contains the key
  ///
  Future<bool> contains(String key);

  /// Delete all the data
  /// @return [Future<void>]
  ///
  Future<void> deleteAll();

  /// Clear box without deleting it
  /// @return [Future<void>]
  ///
  Future<void> clearAll();
}
