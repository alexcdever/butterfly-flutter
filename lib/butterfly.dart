library butterfly;

// 时间戳的长度
const int timeStampSize = 41;
// 高位顺序递进数的长度
const int highSequenceSize = 8;
// 机器编号的长度
const int machineSize = 13;
// 低位顺序递进数的长度
const int lowSequenceSize = 1;

/*
		求最大值的公式的意思是：-1与-1乘以2的Size次方做按位异或运算

		异或运算：对比两组二进制数字的每一位上的数字，不同则在对应的结果的同一位上为1，相同则为0

		-1的二进制表示：11111111 11111111 11111111 11111111 11111111 11111111 11111111 11111111
	*/

// 时间戳最大值，将-1左移41位，则-1变成一个bit长度为41的二进制数字（左边补零）
const int timestampMax = -1 ^ (-1 << timeStampSize);
// 高位顺序递进数最大值
const int highSequenceMax = -1 ^ (-1 << highSequenceSize);
// 机器编号最大值
const int machineMax = -1 ^ (-1 << machineSize);
// 低位顺序递进数最大值
const int lowSequenceMax = 9;
// 生成ID时，机器编号的数值需要左移1位
const int machineShift = lowSequenceSize;
// 生成ID时，高位顺序递进数的数值需要左移14位
const int highSequenceShift = machineSize + lowSequenceSize;
// 生成ID时，时间戳的数值需要左移22位
const int timeStampShift = highSequenceSize + machineSize + lowSequenceSize;

class Butterfly {
  late int timestamp, highSequence, machine, lowSequence;

  Butterfly(this.timestamp, this.highSequence, this.machine, this.lowSequence);
  Butterfly.withTimestampAndMachineNumber(this.timestamp, this.machine) {
    highSequence = 0;
    lowSequence = 0;
  }

  generate() {
    // 判断低位顺序递进数是否为最大值
    if (lowSequence == lowSequenceMax) {
      // 拒绝为机器编号数值大于最大值的发号器实例继续发号
      if (machine > machineMax) {
        return 0;
      }
      // 判断低位顺序递进数是否为最大值
      if (highSequence == highSequenceMax) {
        // 判断时间戳是否为最大值
        if (timestamp == timestampMax) {
          return 0;
        } else {
          // 时间戳+1，高位顺序递进数归零
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
    // 	|是按位或运算符,当存在两个数字进行按位或运算的时候，实际进行运算的是两者的二进制数字；运算时会比较位上的数字，当两者任意一者在同一个位上存在1时，结果的该位上为1，否则为0
    var id = timestamp << timeStampShift |
        highSequence << highSequenceShift |
        machine << machineShift |
        lowSequence;

    return id;
  }

  List<int> batchGenerate(int count) {
    List<int> ids = [];
    for (var i = 0; i < count; i++) {
      ids.add(generate());
    }
    return ids;
  }
}
