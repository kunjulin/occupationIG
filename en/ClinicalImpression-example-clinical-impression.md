# 醫師臨床總評與分級範例 - 臺灣健康檢查資料交換實作指引 (Taiwan Health Assessment Implementation Guide, TWHA IG) v0.1.0

## Example ClinicalImpression: 醫師臨床總評與分級範例

Profile: [健康檢查健檢醫師總評與分級 Profile](StructureDefinition-TWHA-ClinicalImpression.md)

**健康管理分級擴充**: 第一級管理

**status**: Completed

**subject**: [王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))](Patient-example-worker.md)

**assessor**: [Practitioner 林職醫(official)](Practitioner-example-doctor.md)

**summary**: 本次定期健康檢查結果大致正常，既往高血壓控制良好。建議持續維持健康生活習慣，定期監測血壓。



## Resource Content

```json
{
  "resourceType" : "ClinicalImpression",
  "id" : "example-clinical-impression",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-ClinicalImpression"]
  },
  "extension" : [{
    "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-health-mgmt-level",
    "valueCodeableConcept" : {
      "coding" : [{
        "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-HealthMgmtLevel",
        "code" : "level-1",
        "display" : "第一級管理"
      }]
    }
  }],
  "status" : "completed",
  "subject" : {
    "reference" : "Patient/example-worker"
  },
  "assessor" : {
    "reference" : "Practitioner/example-doctor"
  },
  "summary" : "本次定期健康檢查結果大致正常，既往高血壓控制良好。建議持續維持健康生活習慣，定期監測血壓。"
}

```
