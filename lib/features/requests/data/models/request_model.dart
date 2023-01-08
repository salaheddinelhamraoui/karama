import '../../domain/entities/request.dart';

class RequestModel extends Request {
  RequestModel({
    required super.title,
    required super.description,
    required super.products,
    required super.services,
    required super.pereference,
    required super.tags,
    required super.area,
  });
}
