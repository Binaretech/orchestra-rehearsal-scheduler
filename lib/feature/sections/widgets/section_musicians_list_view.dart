import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orchestra_rehearsal_scheduler/feature/sections/provider/sections_provider.dart';
import 'package:orchestra_rehearsal_scheduler/feature/users/data/model/user.dart';

class SectionMusiciansListView extends ConsumerStatefulWidget {
  final int sectionId;
  final void Function(User)? onTap;

  const SectionMusiciansListView(
      {super.key, required this.sectionId, this.onTap});

  @override
  ConsumerState<SectionMusiciansListView> createState() =>
      _SectionMusiciansListViewState();
}

class _SectionMusiciansListViewState
    extends ConsumerState<SectionMusiciansListView> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  final int _perPage = 20;
  bool _isLoadingMore = false;
  List<User> _musicians = [];
  int _totalMusicians = 0;

  @override
  void initState() {
    super.initState();
    _fetchMusicians();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        !_isLoadingMore) {
      if (_musicians.length < _totalMusicians) {
        _fetchMoreMusicians();
      }
    }
  }

  Future<void> _fetchMusicians() async {
    final sectionMusiciansAsync =
        ref.read(getSectionMusiciansProvider(widget.sectionId).future);
    sectionMusiciansAsync.then((response) {
      setState(() {
        _musicians = response.data;
        _totalMusicians = response.total;
      });
    }).catchError((error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: \$error')),
      );
    });
  }

  Future<void> _fetchMoreMusicians() async {
    setState(() {
      _isLoadingMore = true;
    });

    final sectionMusiciansAsync = ref.read(
      getSectionMusiciansProvider(widget.sectionId,
              page: _currentPage + 1, perPage: _perPage)
          .future,
    );
    sectionMusiciansAsync.then((response) {
      setState(() {
        _currentPage++;
        _musicians.addAll(response.data);
        _isLoadingMore = false;
      });
    }).catchError((error) {
      if (!mounted) return;

      setState(() {
        _isLoadingMore = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: \$error')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return _musicians.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            controller: _scrollController,
            itemCount: _musicians.length + (_isLoadingMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == _musicians.length) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final musician = _musicians[index];
              return ListTile(
                title: Text(musician.fullname),
                onTap: () {
                  if (widget.onTap != null) {
                    widget.onTap!(musician);
                  }
                },
              );
            },
          );
  }
}
