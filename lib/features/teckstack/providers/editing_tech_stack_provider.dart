import 'package:haneen_site__api_dashboard/features/teckstack/models/tech_stach_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditingTechStackNotifier extends Notifier<TechStackModel> {
  @override
  TechStackModel build() {
    return TechStackModel.intailValues();
  }

  void editTechStack(TechStackModel techStack) {
    state = techStack;
  }

  void updateTechStack({
    String? name,
    String? slug,
    String? iconUrl,
    int? proficiencyLevel,
    String? description,
    String? coursesLink,
  }) {
    state = state.copyWith(
      name: name ?? state.name,
      slug: slug ?? state.slug,
      iconUrl: iconUrl ?? state.iconUrl,
      proficiencyLevel: proficiencyLevel ?? state.proficiencyLevel,
      description: description ?? state.description,
      coursesLink: coursesLink ?? state.coursesLink,
    );
  }

  void clear() {
    state = TechStackModel.intailValues();
  }
}

final editingTechStackProvider =
    NotifierProvider<EditingTechStackNotifier, TechStackModel>(
      () => EditingTechStackNotifier(),
    );
