import 'package:domain/entities/Product.dart';
import 'package:infra/repository/memory/RepositoryBaseMemory.dart';
import 'package:application/repository/ProductRepository.dart';

class ProductRepositoryMemory extends ProductRepository with RepositoryBaseMemory<Product> {}
