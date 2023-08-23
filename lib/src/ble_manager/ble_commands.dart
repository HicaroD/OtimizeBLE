enum BleCommand {
  // ignore: constant_identifier_names
  StartEvaluation,
}

extension BleCommandBytes on BleCommand {
  List<int> get bytes {
    final bytesPerCommand = {
      BleCommand.StartEvaluation: [0x4, 0x0, 0x0, 0x0, 0x0],
    };
    return bytesPerCommand[this]!;
  }
}
