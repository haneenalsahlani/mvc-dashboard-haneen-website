import 'package:haneen_site__api_dashboard/core/providers/dioProvider.dart';
import 'package:haneen_site__api_dashboard/features/application/models/app_feature_model.dart';
import 'package:haneen_site__api_dashboard/features/application/models/app_model.dart';
import 'package:riverpod/riverpod.dart';

final appProvider = NotifierProvider<AppNotifier, AppModel>(
  () => AppNotifier(),
);

class AppNotifier extends Notifier<AppModel> {
  @override
  AppModel build() {
    return AppModel.intailValues();
  }

  void setIconUrl(String iconUrl) {
    state = state.copyWith(icon: iconUrl);
  }

  void setSlug(String slug) {
    state = state.copyWith(slug: slug);
  }

  void setFeatureImage(List<String> featureImage) {
    final stateFeatures = state.features;

    List<AppFeatureModel> features = featureImage
        .map(
          (e) => AppFeatureModel(
            title: "new feature",
            description: "new feature",
            imageUrl: e,
          ),
        )
        .toList();

    stateFeatures.addAll(features);
    state = state.copyWith(features: stateFeatures);
  }

  void updateAppFeature(int index, String title, String description) {
    final stateFeatures = state.features;
    stateFeatures[index] = stateFeatures[index].copyWith(
      description: description,
      title: title,
    );
    state = state.copyWith(features: stateFeatures);
  }

  void deleteAppFeature(int index) {
    final stateFeatures = state.features;
    stateFeatures.removeAt(index);
    state = state.copyWith(features: stateFeatures);
  }

  void updateFeatureDescription(int index, String value) {
    final stateFeatures = state.features;
    stateFeatures[index] = stateFeatures[index].copyWith(description: value);
    state = state.copyWith(features: stateFeatures);
  }

  void updateFeatureTitle(int index, String value) {
    final stateFeatures = state.features;
    stateFeatures[index] = stateFeatures[index].copyWith(title: value);
    state = state.copyWith(features: stateFeatures);
  }

  void removeFeature(int index, {required String imageUrl}) {
    //delete old image
    final dio = ref.read(dioProvider);
    dio.delete(imageUrl);
    final stateFeatures = state.features;
    stateFeatures.removeAt(index);

    state = state.copyWith(features: stateFeatures);
  }
}
