import 'package:fpdart/fpdart.dart';
import 'core.dart';

typedef FutureEither<T> = Future<Either<Failrue, T>>;
typedef FutureVoid = FutureEither<void>;
