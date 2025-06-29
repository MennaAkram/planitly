import 'package:dartz/dartz.dart';
import '../../../../shared/networking/failures.dart';
import '../entity/home_entity.dart';

abstract class HomeRepository {

  Future<Either<NetworkException, HomeEntity>> getHomeData();
}