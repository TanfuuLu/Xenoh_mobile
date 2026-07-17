import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/dio_provider.dart';
import '../../domain/repositories/community_repository.dart';
import '../datasources/community_remote_data_source.dart';
import 'community_repository_impl.dart';

part 'community_repository_provider.g.dart';

@riverpod
CommunityRepository communityRepository(Ref ref) => CommunityRepositoryImpl(
  CommunityRemoteDataSource(ref.watch(dioProvider)),
);
