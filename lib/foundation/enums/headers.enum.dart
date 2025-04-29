/// Headers
enum Headers {
  /// Client
  customer(label: 'Client'),

  /// Status
  status(label: 'Statut'),

  /// Store
  store(label: 'Magasin'),

  /// Start date
  startDate(label: 'Date début'),

  /// End date
  endDate(label: 'Date fin'),

  /// Price
  price(
    label: 'Montant',
    isNumeric: true,
  ),

  /// Commission
  commission(
    label: 'Commission',
    isNumeric: true,
  ),

  /// Pinned
  pinned(label: ''),

  /// Actions
  actions(label: '');

  /// Constructor
  /// @param [label] label
  /// @param [isNumeric] is numeric
  ///
  const Headers({
    required this.label,
    this.isNumeric = false,
  });

  /// Label
  final String label;

  /// Is numeric
  final bool isNumeric;
}
