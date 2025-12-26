import 'package:haneen_site__api_dashboard/features/blog/models/blog_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final BlogInfoProvider = NotifierProvider<_EditingBlogViewModel, BlogModel>(() {
  return _EditingBlogViewModel();
});

class _EditingBlogViewModel extends Notifier<BlogModel> {
  @override
  build() {
    return BlogModel(
      id: 0,
      title: null,
      slug: null,
      content: null,
      summary: null,
    );
  }

  void reset() {
    state = BlogModel(
      id: 0,
      title: null,
      slug: null,
      content: null,
      summary: null,
    );
  }

  void changeBlog({
    String? id,
    String? newTitle,
    String? newSummary,
    String? newContent,
    String? newSlug,
  }) {
    state = state.copyWith(
      id: id == null ? state.id : int.parse(id),
      title: newTitle ?? state.title,
      summary: newSummary ?? state.summary,
      content: newContent ?? state.content,
      slug: newSlug ?? state.slug,
    );
  }
}
