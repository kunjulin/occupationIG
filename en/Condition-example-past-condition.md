# 既往病史範例 - 高血壓 - 臺灣健康檢查資料交換實作指引 (Taiwan Health Assessment Implementation Guide, TWHA IG) v0.1.0

## Example Condition: 既往病史範例 - 高血壓

Profile: [健康檢查既往病史與不適作業疾病 Profile](StructureDefinition-TWHA-Condition.md)

**clinicalStatus**: Active

**verificationStatus**: Confirmed

**category**: Problem List Item

**code**: Essential (primary) hypertension

**subject**: [王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))](Patient-example-worker.md)



## Resource Content

```json
{
  "resourceType" : "Condition",
  "id" : "example-past-condition",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Condition"]
  },
  "clinicalStatus" : {
    "coding" : [{
      "system" : "http://terminology.hl7.org/CodeSystem/condition-clinical",
      "code" : "active"
    }]
  },
  "verificationStatus" : {
    "coding" : [{
      "system" : "http://terminology.hl7.org/CodeSystem/condition-ver-status",
      "code" : "confirmed"
    }]
  },
  "category" : [{
    "coding" : [{
      "system" : "http://terminology.hl7.org/CodeSystem/condition-category",
      "code" : "problem-list-item"
    }]
  }],
  "code" : {
    "coding" : [{
      "system" : "http://hl7.org/fhir/sid/icd-10-cm",
      "code" : "I10",
      "display" : "Essential (primary) hypertension"
    }]
  },
  "subject" : {
    "reference" : "Patient/example-worker"
  }
}

```
