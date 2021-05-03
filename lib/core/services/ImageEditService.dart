import 'package:image_picker/image_picker.dart';

class ImageEditService {
  Future<PickedFile> selectImageFromCamra() async {
    return await ImagePicker().getImage(source: ImageSource.camera);
  }

  Future<PickedFile> selectImageFromGallery() async {
    return await ImagePicker().getImage(source: ImageSource.gallery);
  }
}
