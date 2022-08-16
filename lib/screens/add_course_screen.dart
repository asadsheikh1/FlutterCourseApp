import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/course.dart';
import '/providers/courses.dart';

class AddCourseScreen extends StatefulWidget {
  const AddCourseScreen({Key? key}) : super(key: key);
  static const routeName = '/add-course';

  @override
  State<AddCourseScreen> createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {
  final _descriptionFocusNode = FocusNode();
  final _ratingFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();

  var _editedCourse = Course(
    id: '',
    title: '',
    description: '',
    rating: 0,
    imageUrl: '',
    playlist: [""],
  );

  var _isLoading = false;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    // ModalRoute.of(context)!.settings.arguments;
    super.initState();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<Courses>(context, listen: false)
          .addCourse(_editedCourse);
    } catch (error) {
      await showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(
              'An error occured!'.toUpperCase(),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            content: Text(
              'Something went wrong.'.toUpperCase(),
              style: Theme.of(context).textTheme.bodyText1,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Okay'.toUpperCase()),
              ),
            ],
          );
        },
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _descriptionFocusNode.dispose();
    _ratingFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Course'.toUpperCase()),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    const Divider(),
                    Text(
                      'Course Info'.toUpperCase(),
                      style: Theme.of(context).textTheme.headline4,
                      textAlign: TextAlign.center,
                    ),
                    const Divider(),
                    TextFormField(
                      decoration:
                          InputDecoration(labelText: 'Title'.toUpperCase()),
                      textInputAction: TextInputAction.next,
                      style: Theme.of(context).textTheme.bodyText1,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      onSaved: (value) {
                        _editedCourse = Course(
                          id: _editedCourse.id,
                          title: value!,
                          description: _editedCourse.description,
                          rating: _editedCourse.rating,
                          imageUrl: _editedCourse.imageUrl,
                          playlist: _editedCourse.playlist,
                        );
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Description'.toUpperCase()),
                      focusNode: _descriptionFocusNode,
                      maxLines: 3,
                      style: Theme.of(context).textTheme.bodyText1,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_ratingFocusNode);
                      },
                      onSaved: (value) {
                        _editedCourse = Course(
                          id: _editedCourse.id,
                          title: _editedCourse.title,
                          description: value!,
                          rating: _editedCourse.rating,
                          imageUrl: _editedCourse.imageUrl,
                          playlist: _editedCourse.playlist,
                        );
                      },
                    ),
                    TextFormField(
                      decoration:
                          InputDecoration(labelText: 'Rating'.toUpperCase()),
                      focusNode: _ratingFocusNode,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      style: Theme.of(context).textTheme.bodyText1,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_imageUrlFocusNode);
                      },
                      onSaved: (value) {
                        _editedCourse = Course(
                          id: _editedCourse.id,
                          title: _editedCourse.title,
                          description: _editedCourse.description,
                          rating: double.parse(value!),
                          imageUrl: _editedCourse.imageUrl,
                          playlist: _editedCourse.playlist,
                        );
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.only(
                            top: 8,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          child: _imageUrlController.text.isEmpty
                              ? Center(
                                  child: Text(
                                    'Enter a URL'.toUpperCase(),
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                )
                              : FittedBox(
                                  child: Image.network(
                                    _imageUrlController.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Image URL'.toUpperCase()),
                            focusNode: _imageUrlFocusNode,
                            style: Theme.of(context).textTheme.bodyText1,
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                            onSaved: (value) {
                              _editedCourse = Course(
                                id: _editedCourse.id,
                                title: _editedCourse.title,
                                description: _editedCourse.description,
                                rating: _editedCourse.rating,
                                imageUrl: value!,
                                playlist: _editedCourse.playlist,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          _saveForm();
        },
        child: const Icon(Icons.save_alt),
      ),
    );
  }
}
