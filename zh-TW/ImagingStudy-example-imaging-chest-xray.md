# 健檢影像檢查範例 - 胸部 X 光 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.10.0

## 範例 ImagingStudy: 健檢影像檢查範例 - 胸部 X 光

Profile: [健康檢查健檢影像檢查 Profile](StructureDefinition-TWHA-ImagingStudy.md)

**status**: Available

**subject**: [王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))](Patient-example-worker.md)

**started**: 2026-06-12 09:45:00+0800

**numberOfSeries**: 1

**numberOfInstances**: 1

**procedureCode**: 胸部X光攝影（後前位）

**reasonCode**: 粉塵作業特殊健康檢查

> **series****uid**: 1.2.826.0.1.3680043.8.498.10001**number**: 1**modality**: [DICOM: DX](http://hl7.org/fhir/R4/codesystem-dicom-dcim.html#dicom-dcim-DX) (Digital Radiography)**description**: Chest PA

### Instances

| | | | |
| :--- | :--- | :--- | :--- |
| - | **Uid** | **SopClass** | **Number** |
| * | 1.2.826.0.1.3680043.8.498.20001 | unknown: urn:oid:1.2.840.10008.5.1.4.1.1.1.1 (urn:oid:1.2.840.10008.5.1.4.1.1.1.1) | 1 |




## Resource Content

```json
{
  "resourceType" : "ImagingStudy",
  "id" : "example-imaging-chest-xray",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-ImagingStudy"]
  },
  "status" : "available",
  "subject" : {
    "reference" : "Patient/example-worker"
  },
  "started" : "2026-06-12T09:45:00+08:00",
  "numberOfSeries" : 1,
  "numberOfInstances" : 1,
  "procedureCode" : [{
    "text" : "胸部X光攝影（後前位）"
  }],
  "reasonCode" : [{
    "text" : "粉塵作業特殊健康檢查"
  }],
  "series" : [{
    "uid" : "1.2.826.0.1.3680043.8.498.10001",
    "number" : 1,
    "modality" : {
      "system" : "http://dicom.nema.org/resources/ontology/DCM",
      "code" : "DX"
    },
    "description" : "Chest PA",
    "instance" : [{
      "uid" : "1.2.826.0.1.3680043.8.498.20001",
      "sopClass" : {
        "system" : "urn:ietf:rfc:3986",
        "code" : "urn:oid:1.2.840.10008.5.1.4.1.1.1.1"
      },
      "number" : 1
    }]
  }]
}

```
