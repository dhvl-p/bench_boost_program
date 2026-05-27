import 'package:graphql/client.dart';
import 'package:bench_boost_program/getx/model/photo_model.dart';

class GraphQLPhotoService {
  late final GraphQLClient _client;

  GraphQLPhotoService() {
    final HttpLink httpLink = HttpLink('https://graphqlzero.almansi.me/api');
    _client = GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(),
    );
  }

  /// Fetches a list of photos using a GraphQL query.
  Future<List<PhotoModel>> fetchPhotos({int limit = 20}) async {
    const String query = r'''
      query GetPhotos($limit: Int) {
        photos(options: { paginate: { limit: $limit } }) {
          data {
            id
            title
            url
            thumbnailUrl
            album {
              id
            }
          }
        }
      }
    ''';

    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: {
        'limit': limit,
      },
      fetchPolicy: FetchPolicy.noCache,
    );

    final QueryResult result = await _client.query(options);

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final List<dynamic>? data = result.data?['photos']?['data'];
    if (data == null) {
      return [];
    }

    return data.map((json) {
      // Map GraphQL response to PhotoModel.
      // GraphQL ID values are typically returned as strings. We parse them into integers.
      final albumIdString = json['album']?['id'] ?? '0';
      final albumId = int.tryParse(albumIdString.toString()) ?? 0;
      
      final idString = json['id'] ?? '0';
      final id = int.tryParse(idString.toString()) ?? 0;

      return PhotoModel(
        albumId: albumId,
        id: id,
        title: json['title'] ?? '',
        url: json['url'] ?? '',
        thumbnailUrl: json['thumbnailUrl'] ?? '',
      );
    }).toList();
  }
}
