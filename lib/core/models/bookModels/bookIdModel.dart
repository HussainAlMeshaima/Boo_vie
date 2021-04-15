// To parse this JSON data, do
//
//     final bookIdVolume = bookIdVolumeFromJson(jsonString);

import 'dart:convert';

BookIdVolume bookIdVolumeFromJson(String str) =>
    BookIdVolume.fromJson(json.decode(str));

String bookIdVolumeToJson(BookIdVolume data) => json.encode(data.toJson());

class BookIdVolume {
  BookIdVolume({
    this.kind,
    this.id,
    this.etag,
    this.selfLink,
    this.volumeInfo,
    this.layerInfo,
    this.saleInfo,
    this.accessInfo,
  });

  String kind;
  String id;
  String etag;
  String selfLink;
  VolumeInfo volumeInfo;
  LayerInfo layerInfo;
  SaleInfo saleInfo;
  AccessInfo accessInfo;

  factory BookIdVolume.fromJson(Map<String, dynamic> json) => BookIdVolume(
        kind: json["kind"] == null ? null : json["kind"],
        id: json["id"] == null ? null : json["id"],
        etag: json["etag"] == null ? null : json["etag"],
        selfLink: json["selfLink"] == null ? null : json["selfLink"],
        volumeInfo: json["volumeInfo"] == null
            ? null
            : VolumeInfo.fromJson(json["volumeInfo"]),
        layerInfo: json["layerInfo"] == null
            ? null
            : LayerInfo.fromJson(json["layerInfo"]),
        saleInfo: json["saleInfo"] == null
            ? null
            : SaleInfo.fromJson(json["saleInfo"]),
        accessInfo: json["accessInfo"] == null
            ? null
            : AccessInfo.fromJson(json["accessInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "kind": kind == null ? null : kind,
        "id": id == null ? null : id,
        "etag": etag == null ? null : etag,
        "selfLink": selfLink == null ? null : selfLink,
        "volumeInfo": volumeInfo == null ? null : volumeInfo.toJson(),
        "layerInfo": layerInfo == null ? null : layerInfo.toJson(),
        "saleInfo": saleInfo == null ? null : saleInfo.toJson(),
        "accessInfo": accessInfo == null ? null : accessInfo.toJson(),
      };
}

class AccessInfo {
  AccessInfo({
    this.country,
    this.viewability,
    this.embeddable,
    this.publicDomain,
    this.textToSpeechPermission,
    this.epub,
    this.pdf,
    this.webReaderLink,
    this.accessViewStatus,
    this.quoteSharingAllowed,
  });

  String country;
  String viewability;
  bool embeddable;
  bool publicDomain;
  String textToSpeechPermission;
  Epub epub;
  Pdf pdf;
  String webReaderLink;
  String accessViewStatus;
  bool quoteSharingAllowed;

  factory AccessInfo.fromJson(Map<String, dynamic> json) => AccessInfo(
        country: json["country"] == null ? null : json["country"],
        viewability: json["viewability"] == null ? null : json["viewability"],
        embeddable: json["embeddable"] == null ? null : json["embeddable"],
        publicDomain:
            json["publicDomain"] == null ? null : json["publicDomain"],
        textToSpeechPermission: json["textToSpeechPermission"] == null
            ? null
            : json["textToSpeechPermission"],
        epub: json["epub"] == null ? null : Epub.fromJson(json["epub"]),
        pdf: json["pdf"] == null ? null : Pdf.fromJson(json["pdf"]),
        webReaderLink:
            json["webReaderLink"] == null ? null : json["webReaderLink"],
        accessViewStatus:
            json["accessViewStatus"] == null ? null : json["accessViewStatus"],
        quoteSharingAllowed: json["quoteSharingAllowed"] == null
            ? null
            : json["quoteSharingAllowed"],
      );

  Map<String, dynamic> toJson() => {
        "country": country == null ? null : country,
        "viewability": viewability == null ? null : viewability,
        "embeddable": embeddable == null ? null : embeddable,
        "publicDomain": publicDomain == null ? null : publicDomain,
        "textToSpeechPermission":
            textToSpeechPermission == null ? null : textToSpeechPermission,
        "epub": epub == null ? null : epub.toJson(),
        "pdf": pdf == null ? null : pdf.toJson(),
        "webReaderLink": webReaderLink == null ? null : webReaderLink,
        "accessViewStatus": accessViewStatus == null ? null : accessViewStatus,
        "quoteSharingAllowed":
            quoteSharingAllowed == null ? null : quoteSharingAllowed,
      };
}

class Epub {
  Epub({
    this.isAvailable,
    this.acsTokenLink,
  });

  bool isAvailable;
  String acsTokenLink;

  factory Epub.fromJson(Map<String, dynamic> json) => Epub(
        isAvailable: json["isAvailable"] == null ? null : json["isAvailable"],
        acsTokenLink:
            json["acsTokenLink"] == null ? null : json["acsTokenLink"],
      );

  Map<String, dynamic> toJson() => {
        "isAvailable": isAvailable == null ? null : isAvailable,
        "acsTokenLink": acsTokenLink == null ? null : acsTokenLink,
      };
}

class Pdf {
  Pdf({
    this.isAvailable,
  });

  bool isAvailable;

  factory Pdf.fromJson(Map<String, dynamic> json) => Pdf(
        isAvailable: json["isAvailable"] == null ? null : json["isAvailable"],
      );

  Map<String, dynamic> toJson() => {
        "isAvailable": isAvailable == null ? null : isAvailable,
      };
}

class LayerInfo {
  LayerInfo({
    this.layers,
  });

  List<Layer> layers;

  factory LayerInfo.fromJson(Map<String, dynamic> json) => LayerInfo(
        layers: json["layers"] == null
            ? null
            : List<Layer>.from(json["layers"].map((x) => Layer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "layers": layers == null
            ? null
            : List<dynamic>.from(layers.map((x) => x.toJson())),
      };
}

class Layer {
  Layer({
    this.layerId,
    this.volumeAnnotationsVersion,
  });

  String layerId;
  String volumeAnnotationsVersion;

  factory Layer.fromJson(Map<String, dynamic> json) => Layer(
        layerId: json["layerId"] == null ? null : json["layerId"],
        volumeAnnotationsVersion: json["volumeAnnotationsVersion"] == null
            ? null
            : json["volumeAnnotationsVersion"],
      );

  Map<String, dynamic> toJson() => {
        "layerId": layerId == null ? null : layerId,
        "volumeAnnotationsVersion":
            volumeAnnotationsVersion == null ? null : volumeAnnotationsVersion,
      };
}

class SaleInfo {
  SaleInfo({
    this.country,
    this.saleability,
    this.isEbook,
    this.listPrice,
    this.retailPrice,
    this.buyLink,
    this.offers,
  });

  String country;
  String saleability;
  bool isEbook;
  SaleInfoListPrice listPrice;
  SaleInfoListPrice retailPrice;
  String buyLink;
  List<Offer> offers;

  factory SaleInfo.fromJson(Map<String, dynamic> json) => SaleInfo(
        country: json["country"] == null ? null : json["country"],
        saleability: json["saleability"] == null ? null : json["saleability"],
        isEbook: json["isEbook"] == null ? null : json["isEbook"],
        listPrice: json["listPrice"] == null
            ? null
            : SaleInfoListPrice.fromJson(json["listPrice"]),
        retailPrice: json["retailPrice"] == null
            ? null
            : SaleInfoListPrice.fromJson(json["retailPrice"]),
        buyLink: json["buyLink"] == null ? null : json["buyLink"],
        offers: json["offers"] == null
            ? null
            : List<Offer>.from(json["offers"].map((x) => Offer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "country": country == null ? null : country,
        "saleability": saleability == null ? null : saleability,
        "isEbook": isEbook == null ? null : isEbook,
        "listPrice": listPrice == null ? null : listPrice.toJson(),
        "retailPrice": retailPrice == null ? null : retailPrice.toJson(),
        "buyLink": buyLink == null ? null : buyLink,
        "offers": offers == null
            ? null
            : List<dynamic>.from(offers.map((x) => x.toJson())),
      };
}

class SaleInfoListPrice {
  SaleInfoListPrice({
    this.amount,
    this.currencyCode,
  });

  double amount;
  String currencyCode;

  factory SaleInfoListPrice.fromJson(Map<String, dynamic> json) =>
      SaleInfoListPrice(
        amount: json["amount"] == null ? null : json["amount"].toDouble(),
        currencyCode:
            json["currencyCode"] == null ? null : json["currencyCode"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount == null ? null : amount,
        "currencyCode": currencyCode == null ? null : currencyCode,
      };
}

class Offer {
  Offer({
    this.finskyOfferType,
    this.listPrice,
    this.retailPrice,
  });

  int finskyOfferType;
  OfferListPrice listPrice;
  OfferListPrice retailPrice;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        finskyOfferType:
            json["finskyOfferType"] == null ? null : json["finskyOfferType"],
        listPrice: json["listPrice"] == null
            ? null
            : OfferListPrice.fromJson(json["listPrice"]),
        retailPrice: json["retailPrice"] == null
            ? null
            : OfferListPrice.fromJson(json["retailPrice"]),
      );

  Map<String, dynamic> toJson() => {
        "finskyOfferType": finskyOfferType == null ? null : finskyOfferType,
        "listPrice": listPrice == null ? null : listPrice.toJson(),
        "retailPrice": retailPrice == null ? null : retailPrice.toJson(),
      };
}

class OfferListPrice {
  OfferListPrice({
    this.amountInMicros,
    this.currencyCode,
  });

  int amountInMicros;
  String currencyCode;

  factory OfferListPrice.fromJson(Map<String, dynamic> json) => OfferListPrice(
        amountInMicros:
            json["amountInMicros"] == null ? null : json["amountInMicros"],
        currencyCode:
            json["currencyCode"] == null ? null : json["currencyCode"],
      );

  Map<String, dynamic> toJson() => {
        "amountInMicros": amountInMicros == null ? null : amountInMicros,
        "currencyCode": currencyCode == null ? null : currencyCode,
      };
}

class VolumeInfo {
  VolumeInfo({
    this.title,
    this.authors,
    this.publisher,
    this.publishedDate,
    this.description,
    this.industryIdentifiers,
    this.readingModes,
    this.pageCount,
    this.printedPageCount,
    this.printType,
    this.categories,
    this.averageRating,
    this.ratingsCount,
    this.maturityRating,
    this.allowAnonLogging,
    this.contentVersion,
    this.panelizationSummary,
    this.imageLinks,
    this.language,
    this.previewLink,
    this.infoLink,
    this.canonicalVolumeLink,
  });

  String title;
  List<String> authors;
  String publisher;
  String publishedDate;
  String description;
  List<IndustryIdentifier> industryIdentifiers;
  ReadingModes readingModes;
  int pageCount;
  int printedPageCount;
  String printType;
  List<String> categories;
  var averageRating;
  int ratingsCount;
  String maturityRating;
  bool allowAnonLogging;
  String contentVersion;
  PanelizationSummary panelizationSummary;
  ImageLinks imageLinks;
  String language;
  String previewLink;
  String infoLink;
  String canonicalVolumeLink;

  factory VolumeInfo.fromJson(Map<String, dynamic> json) => VolumeInfo(
        title: json["title"] == null ? null : json["title"],
        authors: json["authors"] == null
            ? null
            : List<String>.from(json["authors"].map((x) => x)),
        publisher: json["publisher"] == null ? null : json["publisher"],
        publishedDate:
            json["publishedDate"] == null ? null : (json["publishedDate"]),
        description: json["description"] == null ? null : json["description"],
        industryIdentifiers: json["industryIdentifiers"] == null
            ? null
            : List<IndustryIdentifier>.from(json["industryIdentifiers"]
                .map((x) => IndustryIdentifier.fromJson(x))),
        readingModes: json["readingModes"] == null
            ? null
            : ReadingModes.fromJson(json["readingModes"]),
        pageCount: json["pageCount"] == null ? null : json["pageCount"],
        printedPageCount:
            json["printedPageCount"] == null ? null : json["printedPageCount"],
        printType: json["printType"] == null ? null : json["printType"],
        categories: json["categories"] == null
            ? null
            : List<String>.from(json["categories"].map((x) => x)),
        averageRating:
            json["averageRating"] == null ? null : json["averageRating"],
        ratingsCount:
            json["ratingsCount"] == null ? null : json["ratingsCount"],
        maturityRating:
            json["maturityRating"] == null ? null : json["maturityRating"],
        allowAnonLogging:
            json["allowAnonLogging"] == null ? null : json["allowAnonLogging"],
        contentVersion:
            json["contentVersion"] == null ? null : json["contentVersion"],
        panelizationSummary: json["panelizationSummary"] == null
            ? null
            : PanelizationSummary.fromJson(json["panelizationSummary"]),
        imageLinks: json["imageLinks"] == null
            ? null
            : ImageLinks.fromJson(json["imageLinks"]),
        language: json["language"] == null ? null : json["language"],
        previewLink: json["previewLink"] == null ? null : json["previewLink"],
        infoLink: json["infoLink"] == null ? null : json["infoLink"],
        canonicalVolumeLink: json["canonicalVolumeLink"] == null
            ? null
            : json["canonicalVolumeLink"],
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "authors":
            authors == null ? null : List<dynamic>.from(authors.map((x) => x)),
        "publisher": publisher == null ? null : publisher,
        "publishedDate": publishedDate == null ? null : publishedDate,
        "description": description == null ? null : description,
        "industryIdentifiers": industryIdentifiers == null
            ? null
            : List<dynamic>.from(industryIdentifiers.map((x) => x.toJson())),
        "readingModes": readingModes == null ? null : readingModes.toJson(),
        "pageCount": pageCount == null ? null : pageCount,
        "printedPageCount": printedPageCount == null ? null : printedPageCount,
        "printType": printType == null ? null : printType,
        "categories": categories == null
            ? null
            : List<dynamic>.from(categories.map((x) => x)),
        "averageRating": averageRating == null ? null : averageRating,
        "ratingsCount": ratingsCount == null ? null : ratingsCount,
        "maturityRating": maturityRating == null ? null : maturityRating,
        "allowAnonLogging": allowAnonLogging == null ? null : allowAnonLogging,
        "contentVersion": contentVersion == null ? null : contentVersion,
        "panelizationSummary":
            panelizationSummary == null ? null : panelizationSummary.toJson(),
        "imageLinks": imageLinks == null ? null : imageLinks.toJson(),
        "language": language == null ? null : language,
        "previewLink": previewLink == null ? null : previewLink,
        "infoLink": infoLink == null ? null : infoLink,
        "canonicalVolumeLink":
            canonicalVolumeLink == null ? null : canonicalVolumeLink,
      };
}

class ImageLinks {
  ImageLinks({
    this.smallThumbnail,
    this.thumbnail,
    this.small,
    this.medium,
    this.large,
    this.extraLarge,
  });

  String smallThumbnail;
  String thumbnail;
  String small;
  String medium;
  String large;
  String extraLarge;

  factory ImageLinks.fromJson(Map<String, dynamic> json) => ImageLinks(
        smallThumbnail:
            json["smallThumbnail"] == null ? null : json["smallThumbnail"],
        thumbnail: json["thumbnail"] == null ? null : json["thumbnail"],
        small: json["small"] == null ? null : json["small"],
        medium: json["medium"] == null ? null : json["medium"],
        large: json["large"] == null ? null : json["large"],
        extraLarge: json["extraLarge"] == null ? null : json["extraLarge"],
      );

  Map<String, dynamic> toJson() => {
        "smallThumbnail": smallThumbnail == null ? null : smallThumbnail,
        "thumbnail": thumbnail == null ? null : thumbnail,
        "small": small == null ? null : small,
        "medium": medium == null ? null : medium,
        "large": large == null ? null : large,
        "extraLarge": extraLarge == null ? null : extraLarge,
      };
}

class IndustryIdentifier {
  IndustryIdentifier({
    this.type,
    this.identifier,
  });

  String type;
  String identifier;

  factory IndustryIdentifier.fromJson(Map<String, dynamic> json) =>
      IndustryIdentifier(
        type: json["type"] == null ? null : json["type"],
        identifier: json["identifier"] == null ? null : json["identifier"],
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "identifier": identifier == null ? null : identifier,
      };
}

class PanelizationSummary {
  PanelizationSummary({
    this.containsEpubBubbles,
    this.containsImageBubbles,
  });

  bool containsEpubBubbles;
  bool containsImageBubbles;

  factory PanelizationSummary.fromJson(Map<String, dynamic> json) =>
      PanelizationSummary(
        containsEpubBubbles: json["containsEpubBubbles"] == null
            ? null
            : json["containsEpubBubbles"],
        containsImageBubbles: json["containsImageBubbles"] == null
            ? null
            : json["containsImageBubbles"],
      );

  Map<String, dynamic> toJson() => {
        "containsEpubBubbles":
            containsEpubBubbles == null ? null : containsEpubBubbles,
        "containsImageBubbles":
            containsImageBubbles == null ? null : containsImageBubbles,
      };
}

class ReadingModes {
  ReadingModes({
    this.text,
    this.image,
  });

  bool text;
  bool image;

  factory ReadingModes.fromJson(Map<String, dynamic> json) => ReadingModes(
        text: json["text"] == null ? null : json["text"],
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toJson() => {
        "text": text == null ? null : text,
        "image": image == null ? null : image,
      };
}
