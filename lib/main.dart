library butterfly;

/// the bit size of timestamp
const int timeStampSize = 41;

/// the bit size of high sequence
const int highSequenceSize = 8;

/// the bit size of machine number
const int machineSize = 13;

/// the bit size of low sequence
const int lowSequenceSize = 1;

/// the max value of timestamp, the binary format of -1 is: 11111111 11111111 11111111 11111111 11111111 11111111 11111111 11111111
const int timestampMax = -1 ^ (-1 << timeStampSize);

/// the max value of high sequence
const int highSequenceMax = -1 ^ (-1 << highSequenceSize);

/// the max value of machine number
const int machineMax = -1 ^ (-1 << machineSize);

/// the max value of low sequence
const int lowSequenceMax = 9;

/// the shift length of machine number
const int machineShift = lowSequenceSize;

/// the shift length of high sequence
const int highSequenceShift = machineSize + lowSequenceSize;

/// the shift length of timestamp
const int timeStampShift = highSequenceSize + machineSize + lowSequenceSize;

class Butterfly {
  late int timestamp, highSequence, machine, lowSequence;

  Butterfly(this.timestamp, this.highSequence, this.machine, this.lowSequence);
  Butterfly.withTimestampAndMachineNumber(this.timestamp, this.machine) {
    highSequence = 0;
    lowSequence = 0;
  }

  /// generate a new id
  generate() {
    // judge the current low sequence value is max or not
    if (lowSequence == lowSequenceMax) {
      // reject to generate a new id cause the machine number is out of range
      if (machine > machineMax) {
        throw Exception('the timestamp is out of range');
      }
      // judge the current high sequence value is max or not
      if (highSequence == highSequenceMax) {
        // judge the current timestamp value is max or not
        if (timestamp == timestampMax) {
          return 0;
        } else {
          // timestamp adds 1, and the high sequence value to be 0
          timestamp++;
          highSequence = 0;
        }
      } else {
        highSequence++;
      }
      lowSequence = 0;
    } else {
      lowSequence++;
    }
    var id = timestamp << timeStampShift |
        highSequence << highSequenceShift |
        machine << machineShift |
        lowSequence;

    return id;
  }

  /// generate the id list that the length specified by the count
  List<int> batchGenerate(int count) {
    List<int> ids = [];
    for (var i = 0; i < count; i++) {
      ids.add(generate());
    }
    return ids;
  }
}
