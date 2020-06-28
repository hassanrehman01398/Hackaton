import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:covid19/constants/strings.dart';
import 'package:covid19/models/statistics/countries_list_model.dart';
import 'package:covid19/utils/custom_scroll_behaviour.dart';
import 'package:covid19/widgets/country_picker/utils/my_alert_dialog.dart';
import 'package:covid19/widgets/country_picker/utils/typedefs.dart';

/// Provides a customizable [Dialog] which displays all countries
/// with optional search feature

class CountryPickerDialog extends StatefulWidget {
  /// Callback that is called with selected Country
  final ValueChanged<Countries> onValuePicked;

  /// The (optional) title of the dialog is displayed in a large font at the top
  /// of the dialog.
  ///
  /// Typically a [Text] widget.
  final Widget title;

  /// Padding around the title.
  ///
  /// If there is no title, no padding will be provided. Otherwise, this padding
  /// is used.
  ///
  /// This property defaults to providing 12 pixels on the top,
  /// 16 pixels on bottom of the title. If the [content] is not null, then no bottom padding is
  /// provided (but see [contentPadding]). If it _is_ null, then an extra 20
  /// pixels of bottom padding is added to separate the [title] from the
  /// [actions].
  final EdgeInsetsGeometry titlePadding;

  /// Padding around the content.

  final EdgeInsetsGeometry contentPadding;

  /// The semantic label of the dialog used by accessibility frameworks to
  /// announce screen transitions when the dialog is opened and closed.
  ///
  /// If this label is not provided, a semantic label will be infered from the
  /// [title] if it is not null.  If there is no title, the label will be taken
  /// from [MaterialLocalizations.alertDialogLabel].
  ///
  /// See also:
  ///
  ///  * [SemanticsConfiguration.isRouteName], for a description of how this
  ///    value is used.
  final String semanticLabel;

  /// [Comparator] to be used in sort of country list
  final Comparator<Countries> sortComparator;

  /// List of countries that are placed on top
  final List<Countries> priorityList;

  ///Callback that is called with selected item of type Country which returns a
  ///Widget to build list view item inside dialog
  final ItemBuilder itemBuilder;

  /// The (optional) horizontal separator used between title, content and
  /// actions.
  ///
  /// If this divider is not provided a [Divider] is used with [height]
  /// property is set to 0.0
  final Widget divider;

  /// The [divider] is not displayed if set to false. Default is set to false.
  final bool isDividerEnabled;

  /// Determines if search [TextField] is shown or not
  /// Defaults to false
  final bool isSearchable;

  /// The optional [decoration] of search [TextField]
  final InputDecoration searchInputDecoration;

  ///The optional [cursorColor] of search [TextField]
  final Color searchCursorColor;

  ///The search empty view is displayed if nothing returns from search result
  final Widget searchEmptyView;

  ///By default the dialog will be popped of the navigator on selection of a value.
  ///Set popOnPick to false to prevent this behaviour.
  final bool popOnPick;

  final List<Countries> countriesList;

  const CountryPickerDialog({
    Key key,
    this.onValuePicked,
    this.title,
    this.titlePadding,
    this.contentPadding = const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 0.0),
    this.semanticLabel,
    this.sortComparator,
    this.priorityList,
    this.itemBuilder,
    this.isDividerEnabled = false,
    this.divider = const Divider(
      height: 0.0,
    ),
    this.isSearchable = false,
    this.popOnPick = true,
    this.searchInputDecoration,
    this.searchCursorColor,
    this.searchEmptyView,
    this.countriesList,
  }) : super(key: key);

  @override
  SingleChoiceDialogState createState() {
    return SingleChoiceDialogState();
  }
}

class SingleChoiceDialogState extends State<CountryPickerDialog> {
  List<Countries> _allCountries;

  List<Countries> _filteredCountries;

  @override
  void initState() {
    _allCountries = widget.countriesList;

    // Sorting˝ the list based on the comparator provided, if provided
    if (widget.sortComparator != null) {
      _allCountries.sort(widget.sortComparator);
    }

    // If priority countries are provided, adding them to top of the list
    if (widget.priorityList != null) {
      for (final country in widget.priorityList) {
        _allCountries.removeWhere((Countries c) => country.iso2 == c.iso2);
      }
      _allCountries.insertAll(0, widget.priorityList);
    }

    _filteredCountries = _allCountries;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Building the Dialog using Flutter's Alert Dialog with the provided attributes
    return MyAlertDialog(
      title: _buildHeader(),
      contentPadding: widget.contentPadding,
      semanticLabel: widget.semanticLabel,
      content: _buildContent(context),
      isDividerEnabled: widget.isDividerEnabled,
      divider: widget.divider,
    );
  }

  // Returning a List of Countries and a EmptyState text when
  // no countries are present according to the search input
  Widget _buildContent(BuildContext context) {
    return _filteredCountries.isNotEmpty
        ? ScrollConfiguration(
            behavior: const CustomScrollBehaviour(),
            child: ListView(
              shrinkWrap: true,
              children: _filteredCountries
                  .map(
                    (item) => SimpleDialogOption(
                      onPressed: () {
                        widget.onValuePicked(item);
                        if (widget.popOnPick) {
                          Navigator.pop(context);
                        }
                      },
                      child: widget.itemBuilder != null
                          ? widget.itemBuilder(item)
                          : Text(item.name),
                    ),
                  )
                  .toList(),
            ),
          )
        : widget.searchEmptyView ??
            const Center(
              child: Text('No country found.'),
            );
  }

  // Building the Header of the Dialof if
  Widget _buildHeader() {
    return widget.isSearchable
        ? Column(
            children: <Widget>[
              _buildTitle(),
              _buildSearchField(),
            ],
          )
        : _buildTitle();
  }

  // Building the Title of the Dialog
  Widget _buildTitle() {
    return widget.titlePadding != null
        ? Padding(
            padding: widget.titlePadding,
            child: widget.title,
          )
        : widget.title;
  }

  // Building the Search Field of the Dialog
  Widget _buildSearchField() {
    return TextField(
      cursorColor: widget.searchCursorColor,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.search),
        hintText: Strings.countryDialogSearch,
        contentPadding: EdgeInsets.all(1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),
      onChanged: (String value) {
        setState(() {
          _filteredCountries = _allCountries
              .where((country) =>
                  country.name.toLowerCase().startsWith(value.toLowerCase()))
              .toList();
        });
      },
    );
  }
}
