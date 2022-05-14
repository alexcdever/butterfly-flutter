This is a package for generating id.

## Features

This package generates 19 bytes id by timestamp and the machine number. The timestamp should be millisecond format. But the machine number just decided by what you want.
The construction of id is like this:
- timeStampSize = 41;
- highSequenceSize = 8;
- machineSize = 13;
- lowSequenceSize = 1;

## Usage

```dart
// get generator instance by timestamp and machine number
var generator = Butterfly(DateTime.now().millisecondsSinceEpoch, 0);
// generate one id
int id = generator.generate();
// generate specified number of ids
List<int> ids = generator.batchGenerate(10);
```

## Additional information

[repo url](https://github.com/alexcdever/butterfly-flutter)
