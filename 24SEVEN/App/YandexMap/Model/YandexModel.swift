
// MARK: - YandexModel
struct YandexModel: Codable {
    var response: Response?

    enum CodingKeys: String, CodingKey {
        case response = "response"
    }
}

// MARK: - Response
struct Response: Codable {
    var geoObjectCollection: GeoObjectCollection?

    enum CodingKeys: String, CodingKey {
        case geoObjectCollection = "GeoObjectCollection"
    }
}

// MARK: - GeoObjectCollection
struct GeoObjectCollection: Codable {
    var metaDataProperty: GeoObjectCollectionMetaDataProperty?
    var featureMember: [FeatureMember]?

    enum CodingKeys: String, CodingKey {
        case metaDataProperty = "metaDataProperty"
        case featureMember = "featureMember"
    }
}

// MARK: - FeatureMember
struct FeatureMember: Codable {
    var geoObject: GeoObject?

    enum CodingKeys: String, CodingKey {
        case geoObject = "GeoObject"
    }
}

// MARK: - GeoObject
struct GeoObject: Codable {
    var metaDataProperty: GeoObjectMetaDataProperty?
    var name: String?
    var geoObjectDescription: String?
    var boundedBy: BoundedBy?
    var point: Point?

    enum CodingKeys: String, CodingKey {
        case metaDataProperty = "metaDataProperty"
        case name = "name"
        case geoObjectDescription = "description"
        case boundedBy = "boundedBy"
        case point = "Point"
    }
}

// MARK: - BoundedBy
struct BoundedBy: Codable {
    var envelope: Envelope?

    enum CodingKeys: String, CodingKey {
        case envelope = "Envelope"
    }
}

// MARK: - Envelope
struct Envelope: Codable {
    var lowerCorner: String?
    var upperCorner: String?

    enum CodingKeys: String, CodingKey {
        case lowerCorner = "lowerCorner"
        case upperCorner = "upperCorner"
    }
}

// MARK: - GeoObjectMetaDataProperty
struct GeoObjectMetaDataProperty: Codable {
    var geocoderMetaData: GeocoderMetaData?

    enum CodingKeys: String, CodingKey {
        case geocoderMetaData = "GeocoderMetaData"
    }
}

// MARK: - GeocoderMetaData
struct GeocoderMetaData: Codable {
    var precision: String?
    var text: String?
    var kind: String?
    var address: Address?
    var addressDetails: AddressDetails?

    enum CodingKeys: String, CodingKey {
        case precision = "precision"
        case text = "text"
        case kind = "kind"
        case address = "Address"
        case addressDetails = "AddressDetails"
    }
}

// MARK: - Address
struct Address: Codable {
    var countryCode: String?
    var formatted: String?
    var components: [Component]?

    enum CodingKeys: String, CodingKey {
        case countryCode = "country_code"
        case formatted = "formatted"
        case components = "Components"
    }
}

// MARK: - Component
struct Component: Codable {
    var kind: String?
    var name: String?

    enum CodingKeys: String, CodingKey {
        case kind = "kind"
        case name = "name"
    }
}

// MARK: - AddressDetails
struct AddressDetails: Codable {
    var country: Country?

    enum CodingKeys: String, CodingKey {
        case country = "Country"
    }
}

// MARK: - Country
struct Country: Codable {
    var addressLine: String?
    var countryNameCode: String?
    var countryName: String?
    var administrativeArea: AdministrativeArea?

    enum CodingKeys: String, CodingKey {
        case addressLine = "AddressLine"
        case countryNameCode = "CountryNameCode"
        case countryName = "CountryName"
        case administrativeArea = "AdministrativeArea"
    }
}

// MARK: - AdministrativeArea
struct AdministrativeArea: Codable {
    var administrativeAreaName: String?
    var locality: Locality?

    enum CodingKeys: String, CodingKey {
        case administrativeAreaName = "AdministrativeAreaName"
        case locality = "Locality"
    }
}

// MARK: - Locality
struct Locality: Codable {
    var localityName: String?
    var thoroughfare: Thoroughfare?

    enum CodingKeys: String, CodingKey {
        case localityName = "LocalityName"
        case thoroughfare = "Thoroughfare"
    }
}

// MARK: - Thoroughfare
struct Thoroughfare: Codable {
    var thoroughfareName: String?
    var premise: Premise?

    enum CodingKeys: String, CodingKey {
        case thoroughfareName = "ThoroughfareName"
        case premise = "Premise"
    }
}

// MARK: - Premise
struct Premise: Codable {
    var premiseNumber: String?

    enum CodingKeys: String, CodingKey {
        case premiseNumber = "PremiseNumber"
    }
}

// MARK: - Point
struct Point: Codable {
    var pos: String?

    enum CodingKeys: String, CodingKey {
        case pos = "pos"
    }
}

// MARK: - GeoObjectCollectionMetaDataProperty
struct GeoObjectCollectionMetaDataProperty: Codable {
    var geocoderResponseMetaData: GeocoderResponseMetaData?

    enum CodingKeys: String, CodingKey {
        case geocoderResponseMetaData = "GeocoderResponseMetaData"
    }
}

// MARK: - GeocoderResponseMetaData
struct GeocoderResponseMetaData: Codable {
    var point: Point?
    var request: String?
    var results: String?
    var found: String?

    enum CodingKeys: String, CodingKey {
        case point = "Point"
        case request = "request"
        case results = "results"
        case found = "found"
    }
}
