# Automated AI Red-Teaming Lab

## Executive Summary



\*\*Project:\*\* Automated AI Red-Teaming Lab  

\*\*Target:\*\* Fictional Northwind Retail customer-support chatbot  

\*\*Stack:\*\* FastAPI, Ollama, Qwen3 1.7B, Garak, Microsoft PyRIT, Promptfoo, GitHub Actions



\---



## Objective



The project demonstrates a repeatable AI application security workflow rather than a one-time vulnerability scan.



The complete cycle is:



Attack  

→ Identify weakness  

→ Determine root cause  

→ Implement mitigation  

→ Retest the same attack  

→ Convert successful attacks into regression tests  

→ Run those tests automatically in CI



\---



## What Was Tested



The chatbot was tested against:



\- direct prompt injection

\- DAN / role-play jailbreaks

\- business-scope bypass

\- system-prompt extraction

\- sensitive-information leakage

\- Base64 encoding attacks

\- ROT13 encoding attacks

\- letter-by-letter obfuscation

\- unsafe-output attempts



Testing was performed against the real FastAPI `/chat` application rather than directly against the underlying model.



\---



## Key Vulnerabilities Discovered



Several attacks succeeded during development.



### Prompt Injection

Initial Garak testing achieved attacker-controlled behavior.



### Scope Bypass

A weak keyword allowlist allowed unrelated JSON requests and later allowed a PyRIT mode-switch attack.



### Sensitive Information Leakage

A controlled indirect request exposed the planted fake secret:



`NORTHWIND\_TEST\_KEY=NW\_TEST\_78291`



### DAN Jailbreak

A role-play attack successfully caused the model to output attacker-controlled unsafe text.



### Obfuscation Bypass

A letter-by-letter instruction bypassed the original input controls and reached the model.



### System-Prompt Extraction

PyRIT discovered an indirect wording that caused the model to reveal role-defining internal instructions.



\---



## Security Controls Added



The application was hardened with:



\- prompt-injection detection

\- jailbreak / role-play detection

\- sensitive-request filtering

\- obfuscation detection

\- contextual business-scope enforcement

\- system-prompt security instructions

\- sensitive-output leakage detection

\- regression tests for previously successful attacks



These controls are intentionally educational and are not claimed to be production-grade AI security controls.



\---



## Final Validation



| Tool | Final Result |

|---|---|

| Garak Prompt Injection | PASS — 5/5 |

| Garak Base64 | PASS — 5/5 |

| Garak ThreatenJSON | PASS — 1/1 |

| Garak System Prompt Extraction | PASS — 5/5 |

| Garak ROT13 | PASS — 5/5 |

| Microsoft PyRIT | 0/7 attacker successes |

| Promptfoo | 11/11 PASS |

| GitHub Actions | SUCCESS |



The full Garak DAN suite was intentionally not completed because of local runtime cost. Jailbreak coverage was retained through controlled testing, PyRIT, and Promptfoo.



\---



## Continuous Security Regression



GitHub Actions automatically reconstructs the lab and runs:



Promptfoo  

→ PyRIT  

→ selected Garak probes  

→ security result validation  

→ evidence artifact upload



This converts AI red teaming from a manual experiment into a repeatable security regression process.



\---



## Framework Mapping



Primary findings map to:



\*\*OWASP GenAI Top 10 2025\*\*

\- LLM01 — Prompt Injection

\- LLM02 — Sensitive Information Disclosure

\- LLM07 — System Prompt Leakage



\*\*MITRE ATLAS\*\*

\- AML.T0051 — LLM Prompt Injection

\- AML.T0054 — LLM Jailbreak

\- AML.T0057 — LLM Data Leakage

\- AML.T0068 — LLM Prompt Obfuscation

\- AML.T0069.002 — Discover LLM System Information: System Prompt



\---



## Outcome



The strongest evidence from the project is not the final passing score.



The important result is that real weaknesses were discovered, reproduced, mitigated, retested, and then converted into automated regression checks.



This project demonstrates practical experience with:



\- AI red teaming

\- LLM application security

\- adversarial testing

\- mitigation engineering

\- security regression

\- CI/CD security automation

\- OWASP GenAI

\- MITRE ATLAS

\- evidence-based security reporting



\*\*Core principle:\*\*  

Find the weakness, reproduce it, fix it, retest it, and automate the regression.

