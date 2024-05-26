import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../Screen/controller/search_controller.dart';
import '../../../models/anime.dart';
import '../../../utlis/constanst/colors.dart';
import 'appbar.dart';

class AnimeAppBar extends StatefulWidget {
  const AnimeAppBar({super.key});

  @override
  State<AnimeAppBar> createState() => _AnimeAppbarState();
}

class _AnimeAppbarState extends State<AnimeAppBar> {
  final SearchControllers searchController = Get.put(SearchControllers());
  final TextEditingController textEditController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  final RxBool isSearching = false.obs;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _setupSearchListeners();
  }

  void _setupSearchListeners() {
    textEditController.addListener(() {
      if (textEditController.text.isNotEmpty) {
        isSearching.value = true;
        if (_debounce?.isActive ?? false) _debounce!.cancel();
        _debounce = Timer(const Duration(milliseconds: 500), () {
          searchController.setSearchQuery(textEditController.text);
          searchController.resetAndSearch();
        });
      } else {
        isSearching.value = false;
        searchController.clearSearch();
      }
    });
  }

  void _handleSearch() {
    isSearching.value = true;
    searchFocusNode.requestFocus();
  }

  void _closeSearch() {
    isSearching.value = false;
    textEditController.clear();
    searchController.clearSearch();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AAppBar(
          showBackArrow: false,
          backgroundColor: Colors.transparent,
          title: Obx(() =>
              isSearching.value ? _buildSearchField() : _buildDefaultAppBar()),
        ),
        Obx(() {
          if (isSearching.value && searchController.hasSearchResults.value) {
            return Material(
              elevation: 8,
              color: Colors.transparent,
              child: _buildSearchResults(),
            );
          }
          return const SizedBox.shrink();
        }),
      ],
    );
  }

  Widget _buildSearchResults() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AColors.primary,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.5,
      ),
      child: Obx(() {
        if (searchController.isLoading.value &&
            searchController.animeList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else if (searchController.animeList.isEmpty) {
          return const Center(child: Text('No results found'));
        } else {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: searchController.animeList.length + 1,
            itemBuilder: (context, index) {
              if (index < searchController.animeList.length) {
                return _buildAnimeListItem(searchController.animeList[index]);
              } else {
                return _buildLoadMoreButton();
              }
            },
          );
        }
      }),
    );
  }

  Widget _buildLoadMoreButton() {
    return Obx(() {
      if (searchController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return TextButton(
          onPressed: searchController.loadMoreResults,
          child: const Text(
            'Load More',
            style: TextStyle(color: AColors.textColor),
          ),
        );
      }
    });
  }

  Widget _buildSearchField() {
    return TextField(
      focusNode: searchFocusNode,
      controller: textEditController,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'Search for anime..',
        hintStyle: const TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.white70.withOpacity(0.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        prefixIcon: const Icon(Icons.search, color: Colors.white),
        suffixIcon: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: _closeSearch,
        ),
      ),
      textInputAction: TextInputAction.search,
      onSubmitted: (value) {
        if (value.isNotEmpty) {
          searchController.resetAndSearch();
        }
      },
      autofocus: true,
    );
  }

  Widget _buildDefaultAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _appbarButton('Anime'),
        _appbarButton('Series'),
        _appbarButton('Movie'),
        _appbarButton('Manga'),
        IconButton(
          onPressed: _handleSearch,
          icon: const Icon(Iconsax.search_normal, color: AColors.textColor),
        ),
      ],
    );
  }

  Widget _appbarButton(String title) {
    return TextButton(
      onPressed: () {},
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AColors.textColor,
        ),
      ),
    );
  }

  Widget _buildAnimeListItem(Anime anime) {
    return Material(
      elevation: 0,
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(

                  imageUrl: anime.imageUrl,
                  width: 40,
                  height: 50,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const SizedBox(
                    width: 40,
                    height: 40,
                    child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2)),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      anime.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AColors.textColor),
                    ),
                    
                    Row(
                      children: [
                        Icon(Icons.star,color: Colors.yellowAccent, size: 12,),
                        SizedBox(width: 5,),
                        Text(anime.rating.toString(),style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: AColors.textColor),),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    searchFocusNode.dispose();
    textEditController.dispose();
    super.dispose();
  }
}
