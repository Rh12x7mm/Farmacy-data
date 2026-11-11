PRAGMA foreign_keys = ON;

begin TRANSACTION;

DROP TABLE IF EXISTS receipt_item;

DROP TABLE IF EXISTS receipt;

DROP TABLE IF EXISTS employee;

DROP TABLE IF EXISTS indication_generic_index;

DROP TABLE IF EXISTS brand;

DROP TABLE IF EXISTS generic;

DROP TABLE IF EXISTS indication;

DROP TABLE IF EXISTS pharmacy_branch;

CREATE TABLE generic (
    generic_id            INTEGER PRIMARY KEY,
    generic_name          TEXT NOT NULL,
    precaution            TEXT,
    indication            TEXT,
    contra_indication     TEXT,
    dose                  TEXT,
    side_effect           TEXT,
    mode_of_action        TEXT,
    interaction           TEXT
);

CREATE TABLE brand (
    brand_id     INTEGER PRIMARY KEY,
    generic_id   INTEGER NOT NULL,
    manufacturer TEXT,
    brand_name   TEXT NOT NULL,
    form         TEXT,
    strength     TEXT,
    price        REAL,
    packsize     TEXT,
  
    FOREIGN KEY (generic_id) REFERENCES generic(generic_id)
);

CREATE TABLE indication (
    indication_id   INTEGER PRIMARY KEY,
    indication_name TEXT NOT NULL
);

CREATE TABLE indication_generic_index (
    generic_id    INTEGER NOT NULL,
  
    indication_id INTEGER NOT NULL,
  
    PRIMARY KEY (generic_id, indication_id),
  
    FOREIGN KEY (generic_id)    REFERENCES generic(generic_id),
  
    FOREIGN KEY (indication_id) REFERENCES indication(indication_id)
);

CREATE TABLE pharmacy_branch (
    branch_id     INTEGER PRIMARY KEY,
    branch_name   TEXT NOT NULL,
    city          TEXT NOT NULL,
    address       TEXT,
    phone         TEXT,
    open_time     TEXT,
    close_time    TEXT,
    opened_year   INTEGER
);

CREATE TABLE employee (
    employee_id INTEGER PRIMARY KEY,
    last_name   TEXT NOT NULL,
    first_name  TEXT NOT NULL,
    middle_name TEXT,
    position    TEXT NOT NULL,
    branch_id   INTEGER NOT NULL,
    phone       TEXT,
    hire_date   TEXT,
    salary      INTEGER CHECK (salary > 0),
    FOREIGN KEY (branch_id) REFERENCES pharmacy_branch(branch_id)
);

CREATE TABLE receipt (
    receipt_id     INTEGER PRIMARY KEY,
    branch_id      INTEGER NOT NULL,
    employee_id    INTEGER NOT NULL,
    receipt_date   TEXT NOT NULL,
    payment_method TEXT NOT NULL CHECK (payment_method IN ('Наличные', 'Карта', 'СБП')),
    FOREIGN KEY (branch_id)   REFERENCES pharmacy_branch(branch_id),
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
);

CREATE TABLE receipt_item (
    receipt_id INTEGER NOT NULL,
    brand_id   INTEGER NOT NULL,
    quantity   INTEGER NOT NULL CHECK (quantity > 0),
    unit_price REAL    NOT NULL CHECK (unit_price >= 0),
  
    PRIMARY KEY (receipt_id, brand_id),
  
    FOREIGN KEY (receipt_id) REFERENCES receipt(receipt_id),
  
    FOREIGN KEY (brand_id)   REFERENCES brand(brand_id)
);

INSERT INTO generic VALUES(61, 'Amlodipine  +  Atenolol', 'Excessive fall of BP may occur in elderly patients. Caution in patients with COPD, thyrotoxicosis, congestive failure, vasospastic angina, hepatic & renal impairment. Caution in diabetic patients as beta-blockers may mask tachycardia occurring with hypoglycaemia. Withdrawal
                           should be gradual. Lactation. Safety and efficacy have not been established in children. Not to be used in untreated phaeochromocytoma.', 'Patients with essential hypertension; Patients with angina pectoris & hypertension as co-existing diseases; In post MI patients; In patients with refractory angina pectoris where nitrate therapy has failed.',
                           'Hypotension, sinus bradycardia, 2nd & 3rd degrees of heart block, cardiogenic shock, overt congestive failure, poor LV function, hypersensitivity to either component, pregnancy.', 'Adult: PO HTN; Chronic stable angina Per tab contains amlodipine (besylate) 5 mg and atenolol 25 or 50 mg: 1 tab once daily, up to 2 tab/day if needed.', 'Headache, hypotension, dizziness, breathlessness,
                           fatigue, muscle cramps, bradycardia, palpitations, flushing, oedema, dyspnoea, dyspepsia, cold extremities. Drowsiness, chestpain & impotence rarely. Hypersensitivity reactions.', 'Atenolol is a cardioselective beta blocker. Amlodipine is a dihydropyridine calcium-channel blocker that blocks the transmembrane influx
                           of calcium ions into vascular smooth muscle and cardiac muscle. Combination of the two drugs results
                           in additive antihypertensive action.', 'Additive effect when used with catecholamine depleting drugs; monitor for hypotension and/or marked bradycardia.
                           If used with clonidine, clonidine withdrawal should occur a few days after withdrawal of the beta-blocker to prevent rebound hypertension; if replacing clonidine by beta-blocker, beta-blocker should be introduced only after clonidine administration has stopped for several days.
                           Concurrent use with prostaglandin synthase inhibiting drugs (e.g. indomethacin) may reduce the hypotensive effects of beta-blockers.');
INSERT INTO generic VALUES(135, 'Aspirin + Clopidogrel', 'History of peptic ulcer or those prone to dyspepsia and those with gastric mucosal lesion or heavy ethanol consumption; asthma or allergic disorders; tinnitus; dehydrated patients; uncontrolled hypertension; impaired renal or hepatic function; children and elderly; pregnancy. Patients at risk of increased bleeding from trauma, 
                           surgery, or other pathological conditions. Increased risk of Reye''s syndrome when used in patients with chicken pox, influenza or flu symptoms. Caution when used in patients with nasal allergies or nasal polyps. For patients undergoing elective surgery and an antiplatelet effect is not needed, clopidogrel should be discontinued 7-10 days before surgery.',
                           'Acute coronary syndrome, TIA, Ischaemic events, MI, Stroke', 'Hypersensitivity to aspirin, NSAIDs or clopidogrel; active peptic ulceration; children <12 yr; patients with haemophilia or haemorrhagic disorders; gout; severe renal or hepatic impairment; lactation.', 'Adult: PO Prevention of ischaemic events Per tab contains clopidogrel 75 mg and aspirin 75 mg: 1 tab once daily.
                           Acute coronary syndrome Per tab contains clopidogrel 75 mg and aspirin 75 mg: Loading dose: 4 tab; maintenance: 1 tab/day.

Renal impairment:
CrCl (ml/min)	
<10	   Avoid use.
Hepatic impairment: Severe hepatic impairment: Avoid use.', 'Aspirin: GI disturbances, epigastric discomfort, prolonged bleeding time, rhinitis, urticaria; angioedema, salicylism, tinnitus. Clopidogrel: Dyspepsia, abdominal pain, nausea, vomiting, flatulence, constipation, gastritis, gastric and duodenal ulcers. Serious events include bleeding and GI haemorrhage. GI upset, diarrhoea, paraesthesia, vertigo, headache, dizziness, leucopaenia, eosinophilia, rash and pruritus.
Potentially Fatal: Aspirin: Gastric erosion, ulceration and bleeding; severe, occasionally fatal exacerbation of airway obstruction in asthma; Reye''s syndrome (childn <12 yrs). Hepatotoxicity; CNS depression, which may lead to coma; CV collapse, resp failure; paroxysmal bronchospasm and dyspnoea. Clopidogrel: Bleeding disorders including GI intracranial haemorrhage and thrombotic thrombocytopenic purpura.', 'Aspirin inhibits the formation of thromboxane A2 in the platelets. This inhibits platelet aggregation and coagulation.
                           This action lasts until the enzyme cyclo-oxygenase is regenerated in the platelets. Clopidogrel is a prodrug and is metabolised an active thiol metabolite. The active metabolite selectively inhibits the binding of adenosine diphosphate (ADP) to its platelet receptor and the subsequent ADP-mediated activation of the glycoprotein GP IIb/IIIa complex, thereby inhibiting platelet aggregation.', 'Aspirin: Corticosteroids, phenylbutazone and oxyphenbutazone may increase risk of GI ulceration. Use with coumarins,
                           anagrelide, agatroban, LMWH, bivalirudin, dasatinib, iloprost, lepirudin and tenecteplase may increase the risk of bleeding. Clopidogrel: Co-administration of clopidogrel with NSAIDs may increase the risk of stomach and intestinal bleeding. There is an increased risk of bleeding with coumarins, agatroban, dasatinib, heparin, LMWH, gingko biloba and iloprost. Increased risk of bleeding if clopidogrel and drotrecogin alfa are given within 7 days. May increase bupropion level and side effects (lightheadedness , GI discomfort).
Potentially Fatal: Aspirin and clopidogrel: Increased risk of bleeding with dabigatran.');

INSERT INTO generic VALUES(141, 'Atorvastatin', 'Patients who consume substantial quantities of alcohol. History of liver disease. Patients with risk factors for myopathy or rhabdomyolysis. Hypothyroidism should be properly managed prior to starting statin therapy. Children <10 yr. Premenarcheal females.',
                           'Primary hypercholesterolemia (heterozygous familial and nonfamilial), Mixed Dyslipidemia, Homozygous familial hypercholesterolemia, Hypertriglyceridemia, Familial hypercholesterolemia, Cardiovascular event prevention, Primary dysbetalipoproteinemia', 'Hypersensitivity, active liver disease or unexplained persistent elevations of serum transaminase, porphyria, pregnancy, lactation.', 'Oral
Mixed dyslipidaemia, Heterozygous familial hypercholesterolaemia, Nonfamilial hypercholesterolaemia
                        
Adult: Initially, 10 or 20 mg once daily, may be adjusted at 4-wk interval. May initiate 40 mg once daily in patients who require >45% reduction in LDL-cholesterol. Max: 80 mg/day.

Child: Heterozygous familial hypercholesterolaemia: 10-17 yr 10 mg once daily, may increase at intervals of at least 4 wk to max 20 mg/day.
Elderly: No dosage adjustment needed.

Atorvastatin can be administered as a single dose at any time of the day, with or without food. Therapy should be individualized according to goal of therapy and response. After initiation and/or upon titration of Atorvastatin, lipid levels should be analyzed within 2 to 4 weeks and dosage adjusted accordingly. Since the goal of treatment is to lower LDL-C, the LDL-C levels should be used to initiate and assess treatment response.
                           Only if LDL-C levels are not available, should total-C be used to monitor therapy. 

Homozygous Familial Hypercholesterolemia: The dosage of Atorvastatin in patients with homozygous FH is 10 to 80 mg daily. Atorvastatin should be used as an adjunct to other lipid-lowering treatments (eg, LDL apheresis) in these patients or if such treatments are unavailable. 

Dosage in Patients with Renal Insufficiency: Renal disease does not affect the plasma concentrations or LDL-C reduction of atorvastatin; thus, dosage adjustment in patients with renal dysfunction is not necessary. 

Pediatric Use: Treatment experience in a pediatric population is limited to doses of Atorvastatin up to 80 mg/day for 1 year in 8 patients with homozygous FH. No clinical or biochemical abnormalities were reported in these patients. None of these patients was below 9 years of age. 

Geriatric Use: Treatment experience in adult’s age 70 years with doses of Atorvastatin up to 80 mg/day has been evaluated. The safety and efficacy of Atorvastatin in this population were similar to those of patients <70 years of age.', 'Headache, flatulence, diarrhoea, nausea, vomiting, anorexia, xerostomia, angioedema, myalgia, rash/pruritus, alopecia, allergy, infection, chest pain.Potentially Fatal:
                           Thrombocytopenia. Rhabdomyolysis with acute renal failure.', 'Atorvastatin competitively inhibits HMG-CoA reductase, the enzyme that catalyses the conversion of HMG-CoA to mevalonate. This results in the induction of the LDL receptors and stimulation of LDL catabolism, leading to lowered LDL-cholesterol levels.', 'May increase risk of myopathy and rhabdomyolysis w/ CYP3A4 potent inhibitor
                           (e.g. HIV or HCV protease inhibitors, itraconazole, clarithromycin), fenofibrate, colchicines, fixed combination of lopinavir/ritonavir. May decrease plasma concentration w/ CYP3A4 inducer (e.g. rifampicin, efavirenz). May significantly increase AUC and peak plasma concentration of digoxin. Increased AUC for norethindrone and ethinyl estradiol.
Potentially Fatal: Increased risk of myopathy or rhabdomyolysis w/ ciclosporin, gemfibrozil, telaprevir, tipranavir.');

INSERT INTO generic VALUES(336, 'Cephradine', 'Renal impairment; history of penicillin sensitivity; pregnancy; lactation.', 'Pneumonia, Pharyngitis, Susceptible infections, Otitis media, Skin and Skin-Structure Infections, Rheumatic fever, Tonsillitis, Respiratory tract infections, Urinary tract infections, Surgical
                           Prophylaxis, Genitourinary tract infections, Acute prostatitis',
                           'Hypersensitivity to cefradine or other cephalosporins; porphyria.', 'Adult: PO Susceptible infections 1-2 g/day in 2-4 divided doses. Max: 4 g/day. 

IV/IM Severe infections 2-4 g/day in divided doses. Max: 8 g/day. 

Surgical prophylaxis 1-2 g pre-op. Subsequent doses may be given as needed. 
Skin and skin structures and respiratory tract infection: Usual dose is 250 mg every 6 hours or 500 mg every 12 hours. 

Lobar pneumonia: 500 mg every 6 hours or 1 gm every 12 hours. 
Urinary tract infection: Usual dose is 500 mg every 12 hours. 
Gastro-intestinal tract infection: 500 mg three to four times daily. 

Children: Oral: The usual total dose is 25 to 50 mg/kg/day given in 2 to 4 equally divided doses. 

Injection: 50 to 100 mg/kg/day in 4 equally divided doses. The usual total dose may be increased up to 200-300 mg/kg/day. 
Perioperative prophylaxis: Recommended dose is 1-2 gm by intramuscular or intravenous route; subsequent parenteral or oral doses are given as appropriate. 

Renal impairment: For patients undergoing chronic intermittent haemodialysis: 250 mg may be given at the start of the session, repeated after 6-12 hr, then again 36-48 hr after the initial dose,
                           and again at the start of the next haemodialysis if >30 hr have elapsed since the previous dose.

CrCl (ml/min)	
>20	        500 mg every 6 hr.
5-20        250 mg every 6 hr.
<5	        250 mg every 12 hr.', 'Diarrhoea, nausea, vomiting; leukopenia, neutropenia, eosinophilia, rash, pruritus; joint pain; increased BUN and creatine; dizziness.
Potentially Fatal: Pseudomembranous colitis.', 'Cefradine is a 1st generation cephalosporin which inhibits the final transpeptidation step of the peptidoglycan synthesis in bacterial cell wall by binding to one or more of the penicillin-binding proteins (PBPs), thus arresting cell wall synthesis leading to bacterial cell death.',
                           'Increased risk of nephrotoxicity w/ loop diuretics. Decreased renal clearance w/ probenecid.');

INSERT INTO generic VALUES(386, 'Ciprofloxacin', 'Epilepsy, history of CNS disorders; severe renal or hepatic dysfunction; G6PD deficiency; maintain adequate hydration; myasthaenia gravis. Caution when used in patients with QT prolongation or risk factors e.g. bradycardia, pre-existing cardiac disease 
                           or uncorrected electrolyte disturbances. Discontinue treatment if patients experience tendon pain,
                           inflammation or rupture. Avoid usage in methicillin-resistant staphylococcus aureus (MRSA) infections due to high level of resistance. May impair ability to drive or operate machinery. Safety and efficacy have not been established in pregnant and
                           lactating women. Not to be used in children <18 yr; except where benefit clearly exceeds risk.', 'Cystic fibrosis, Intra-abdominal infections, Meningitis,
                           Peritonitis, Endocarditis, Anthrax, Otitis media, Septicaemia, Lower Respiratory Tract Infections,
                           Cystitis, Gonorrhoea, Skin and skin structure infections, Nosocomial pneumonia,
                           Urinary tract infections, Enteric fever, Bone and Joint Infections, Biliary tract infections, Surgical Prophylaxis, Gastroenteritis, Q fever, Acute Sinusitis, Cat scratch disease, Spotted fever,
                           Typhus, Chanroid, Brucellosis, Typhoid and paratyphoid fever, Superficial ophthalmic infections, Otitis externa',
                           'Hypersensitivity. Not to be used concurrently with tizanidine. Avoid exposure to strong sunlight or sun lamps during treatment.', 'Adult Dose: For oral dosage & suspension: 
                           Urinary Tract infection: Acute uncomplicated: 250 mg twice daily for 3 days; Mild/Moderate: 250 mg twice daily for 7 to 14 days; Severe/Complicated: 500 mg twice daily for 7 to 14 days; 

Chronic Bacterial Prostitis : 500 mg twice daily for 28 days; 

Lower Respiratory Tract infection: Mild/Moderate: 500 mg twice daily for 7 to 14 days, Severe/Complicated : 750 mg twice daily for 7 to 14 days; 

Acute Sinusitis : 500 mg twice daily for 10 days; Skin and Skin Structure infection: Mild/Moderate : 500 mg twice daily for 7 to 14 days, Severe/Complicated : 750 mg twice daily for 7 to 14 days, 

Bone and joint infection: Mild/Moderate 500 mg twice daily for 4 to 6 weeks, Severe/Complicated : 750 mg twice daily for 4 to 6 weeks, 

Intra Abdominal Infection: 500 mg twice daily for 7 to 14 days, Infectious Diarrhea: Mild/Moderate/Severe: 500 mg twice daily for 5 to 7 days, Typhoid Fever : 500 mg twice daily for 10 days, 

Urethral & Cervical Gonococcal Infections: Uncomplicated: 250 mg Single dose. 

For IV infusion : Urinary Tract Infection: Mild to Moderate: 200 mg 12 hourly for 7-14 days;Severe or Complicated: 400 mg 12 hourly for 7-14 days; 

Lower Respiratory Tract infection: Mild to Moderate: 400 mg 12 hourly for 7-14 days; Severe or Complicated: 400 mg 8 hourly for 7-14 days; Nosocomial Pneumonia: Mild/Moderate/Severe: 400 mg 8 hourly for 10-14 days; 

Skin and Skin Structure: Mild to Moderate: 400 mg 12 hourly for 7-14 days; Severe or Complicated: 400 mg 8 hourly for 7-14 days; Bone and Joint Infection: Mild to Moderate: 400 mg 12 hourly for more than 4-6 weeks; Severe/Comlicated: 400 mg 8 hourly for more than 4-6weeks; 

Intra abdominal (Acute abdomen): Complicated: 400 mg 12 hourly for 7-14 days; Acute Sinusitis: Mild/Moderate: 400 mg 12 hourly for10 days: 
Chronic Bacterial Prostatitis: Mild/Moderate: 400 mg 12 hourly for 28 Days. 

Children and adolescents: RTI & GI infections: Neonate-15mg/kg twice daily, Child (1 month -18 years)-20mg/kg (max 750 mg) twice daily; 
UTI: Neonate-10 mg/kg twice daily, Child (1 month -18 years)-10mg/kg (max 750 mg) twice daily; 

Pseudomonal lower respiratory tract infection in cystic fibrosis: Child (1 month -18 years) - 20mg/kg (max 750 mg) twice daily; Anthrax (treatment & post exposure prophylaxis): Child (1 month -18 years) - 20mg/kg (max 750 mg) twice daily.', 'GI disturbances; headache, tremor, confusion, convulsions; rashes; joint pain; phototoxicity. 
                           Transient increases in serum creatinine. Haematological, hepatic and renal disturbances. Vasculitis, pseudomembranous colitis and tachycardia. Phototoxicity.
Potentially Fatal: Anaphylactoid reaction; cardiopulmonary arrest.', 'Ciprofloxacin promotes breakage of double-stranded DNA in susceptible organisms and inhibits DNA gyrase, which is essential in reproduction of bacterial DNA.', 'May increase plasma concentrations of CYP1A2 substrates (e.g. clozapine, ropinirole, theophylline).
                           Enhances effect of oral anticoagulants (e.g. warfarin) and glibenclamide. Increased toxicity of methotrexate. Plasma concentrations may be increased by probenecid. Reduced absorption w/ oral multivitamins and mineral supplements containing divalent or trivalent cations (e.g. Fe, Zn, Ca) and antacids containing Al, Ca or Mg. Concomitant use w/ class IA antiarrhythmics (e.g. quinidine, procainamide),
                           class III antiarrhythmics (e.g. amiodarone, sotalol), TCAs, macrolides and antipsychotics may result in additive effects on QT interval prolongation. Concurrent use w/ corticosteroids may increase risk of severe tendon disorders. Increased risk of CNS stimulation w/ NSAIDs. Altered serum concentrations of phenytoin.
Potentially Fatal: Marked elevation in serum levels of tizanidine which is associated w/ potentiated hypotensive and sedative effect.');

INSERT INTO generic VALUES(489, 'Dexamethasone 0.1% + Tobramycin 0.3% Eye prep', 'Pregnancy and lactation. Avoid prolonged use, monitor intraocular pressure routinely. Safety and effectiveness in children <2 yr not established.', 'Bacterial eye infections, Ocular inflammation, Pink eye', 'Viral infections of corneal and conjunctiva (e.g. epithelial herpes simplex keratitis, vaccinia, varicella).
                           Mycobacterial or fungal infection of the eye.', 'Adult: Ophth As susp containing tobramycin 0.3% and dexamethasone 0.1%: Instill 1-2 drops 4-6 hrly. May increase to 2 hrly during the initial 24-48 hr, reduce frequency gradually as improvement seen. As oint containing tobramycin 0.3% and dexamethasone 0.1%: Apply half an inch ?3-4 times/day.', 'Hypersensitivity reactions, lid
                           itching and swelling, conjunctival erythema, increase in intraocular pressure, glaucoma, optic nerve damage,
                           posterior subcapsular cataract formation and delayed wound healing. Secondary infections especially after prolonged use.',
                           'Tobramycin, an aminoglycoside antibiotic, has actions similar to that of gentamicin and is active against Staphylococci, Streptococci, Pseudomonas aeruginosa, Escherichia coli, Klebsiella pneumoniae, Enterobacter aerogenes, Proteus mirabilis, Morganella morganii, most Proteus vulgaris strains, Haemophilus influenzae and H.
                           aegyptius, Moraxella lacunata, Acinetobacter calcoaceticus and some Neisseria species. Dexamethasone, a synthetic fluorinated corticosteroid, has mainly glucocorticoid activity and suppresses inflammatory response.', 'Enhanced neurotoxic and nephrotoxic effects w/ other aminoglycosides
                           (e.g. amikacin, streptomycin), cefaloridine, viomycin, polymyxin B, colistin, cisplatin and vancomycin.
                           Enhanced toxicity w/ potent diuretics (e.g. ethacrynic acid, furosemide). Prolonged secondary apnoea may occur when given to anaesthetised patients receiving neuromuscular blocking agents (e.g. succinylcholine, tubocurarine, decamethonium). Increased risk of nephrotoxicity w/ ciclosporin and other antibacterials (e.g. cephalosporins). Antagonistic effect w/ neostigmine and pyridostigmine. May potentiate the effect of warfarin and phenindione.');
INSERT INTO generic VALUES(538, 'Diclofenac Sodium', 'History of gastrointestinal ulceration, haematemesis or melaena, ulcerative colitis, Asthma or history of asthma, Crohn''s disease, bleeding diathesis or haematological abnormalities. Patients with severe hepatic, cardiac or renal insufficiency or the elderly people, Current or previous high blood pressure ( hypertension) should be kept under close surveillance. All patients who are receiving long-term treatment with NSAID agents should be monitored as a precautionary measure (e.g., renal, hepatic function and blood counts).If abnormal liver function tests persist or worsen,
                           clinical signs and symptoms consistent with liver disease develop or if other manifestations occur, Diclofenac sodium should be discontinued. Use of Diclofenac tablet in patients with hepatic porphyria may trigger an attack.', 'Rheumatoid arthritis, Osteoarthritis, Ankylosing spondylitis, Pain, Migraine, Dysmenorrhea, Muscle aches, Acute gout, Inflammation, Renal colic,Tendinitis, Backaches, Dental pain, Menstrual cramps, Bursitis', 'It is contra-indicated for those patients who are hypersensitive to Diclofenac. In patients with active or suspected peptic ulcer or gastrointestinal bleeding, 
                           or for those patients in whom attacks of asthma,
                           urticaria or acute rhinitis are precipitated by aspirin or other NSAIDs possessing prostaglandin synthetase inhibitinig activity, it is also contraindicated.
Because of the presence of Lidocaine, it is also contraindicated for those patients who are hypersensitive to local anaesthetics of the amide type, although the incidence is very rare.', 'Adults: 1- 3 tablet (50 -150 mg) daily in divided doses preferably with food or after food.

Children: 1- 3 mg/kg body weight per day in divided doses.

 Injections are intended for intramuscular injection.

Adults: The dosage is generally one 75 mg ampoule daily. In severe cases (e.g. colic) the daily dose can exceptionally be increased to two ampoules of 75 mg, separated by an interval of a few hours. Alternatively, one ampoule of 75 mg can be combined with other dosage forms (tablets, suppositories) up to a maximum daily dosage of 150 mg.

In migraine attacks, clinical experience is limited to initial use of 1 ampoule of 75 mg administered as soon as possible, followed by suppositories up to 100 mg on the same day if required. The total dosage should not exceed 175 mg on the first day.

Children: In juvenile chronic arthritis, 1-3 mg of Diclofenac sodium/kg body weight daily in divided doses.

Elderly patients: The lowest effective dosage is recommended, commensurate with age and physical status or as prescribed by the physician.

Suppository: For adults: 50 mg suppository 2-3 times daily. Maximum daily dose is 150 mg.', 'Side-effects of Diclofenac is usually mild and transient. It is generally well tolerated. At the starting of the treatment, however, patients may sometimes complain of gastrointestinal discomfort, epigastria pain, eructation, nausea and Diarrhoea, headache and bleeding sometime may occur. Occasionally skin rash, peripheral oedema and abnormalities of serum transaminase have been reported.Very rarely reported side effects include activation of peptic ulcer, haematemesis or melena, blood dyscrasia (extensive usage). There have been isolated reports of anaphylactoid reactions.',
                           'Diclofenac, a phenylacetic acid derivative is a prototypical NSAID. It has potent anti-inflammatory,
                           analgesic and antipyretic actions. It reversibly inhibits the enzyme, cyclooxygenase, thus resulting in reduced synthesis of prostaglandin precursors.', 'May increase serum levels of methotrexate. Concomitant use w/ other NSAIDs or anticoagulants (e.g. warfarin) is associated w/ higher risk of GI bleeding. Increased risk of nephrotoxicity w/ ciclosporin or triamterene. May increase the risk of developing corneal complications in patients w/ significant pre-existing corneal inflammation when use concomitantly w/ ophth preparation containing corticosteroids.
                           Colestyramine and colestipol reduce the bioavailability of diclofenac. Decreased plasma concentration when administered after sucralfate. Ophth application of diclofenac may reduce the efficacy of ophth acetylcholine and carbachol. May increase serum levels of lithium and digoxin.');
INSERT INTO generic VALUES(650, 'Etoricoxib', 'Allergic disorders, coagulation defects; history of cardiac failure, left ventricular dysfunction, hypertension, or in patients with oedema due to other reasons; elderly, renal, cardiac or hepatic impairment. Withdraw treatment if GI lesions develop; caution when admin to dehydrated patients. Regular BP monitoring is advisable. May mask fever and other signs of infection. Pregnancy.', 'Rheumatoid arthritis, Osteoarthritis, Gout', 'Inflammatory bowel disease, severe congestive heart failure, active peptic ulceration, cerebrovascular disease, CrCL <30 ml/min; lactation. Children and adolescent < 16 yr.',
                           'Adult: PO Osteoarthritis 60 mg once daily. Rheumatoid arthritis 90 mg once daily. Acute gout 120 mg once daily. Max duration: 8 days.

Child: <16 yr Contraindicated.
Hepatic impairment: Mild (Child-Pugh score of 5-6): 60 mg once daily. Moderate (Child-Pugh 7-9): Max 60 mg every other day or 30 mg once daily. Severe (Child-Pugh >10): Avoid.', 'GI disorders; ischemic cardiac events; hypersensitivity reactions, headache, dizziness, nervousness, depression, drowsiness, insomnia, vertigo, tinnitus, photosensitivity; blood disorders, fluid retention, hypertension; dry mouth, taste disturbance, mouth ulcers; appetite and wt changes; chest pain, fatigue, paraesthesia, influenza-like syndrome, myalgia. Renal toxicity.', 'Etoricoxib is a selective cyclooxygenase-2 (COX-2) inhibitor primarily responsible to reduce mediators of pain and inflammation. Its action is due to inhibition
                           of prostaglandin synthesis via inhibition of COX-2.',
                           'May increase INR w/ oral anticoagulants.
                           May decrease effects of ACE inhibitors, angiotensin II antagonist and diuretics. May increase lithium plasma concentrations. May reduce plasma levels w/ rifampicin. Increased serum concentrations of ethinylestradiol.');
INSERT INTO generic VALUES(956, 'Meclizine Hydrochloride + Pyridoxine Hydrochloride', 'Prostate hypertrophy, obstruction of bladder neck, narrow angle glaucoma, pyloric stenosis. May impair ability to drive or operate machinery. Pregnancy.', 'Nausea, vomiting, dizziness, motion sickness, radiation sickness and vertigo associated with diseases of vestibular motion sickness, radiation sickness and vertigo associated with diseases of vestibular system, morning sickness during pregnancy, drug induced nausea, vomiting induced by oral contraceptives or Estrogen preparations.', 'Meclizine Hydrochloride and Pyridoxine Hydrochloride is contraindicated in patients who are hypersensitive to these ingredients.',
                           'Adult: PO: As combination preparation containing meclozine 25 mg and pyridoxine 50 mg per tablet:
                           1 tablet at night.', 'Drowsiness, thickening of bronchial secretions, dry mouth, fatigue, blurred vision.', 'Meclozine blocks vasopressor response to histamine and has a slight blocking action against acetylcholine. It decreases excitability of the middle ear labyrinth and blocks conduction in the middle ear vestibular-cerebellar pathways.

Pyridoxine is a water-soluble vitamin which functions in the metabolism of carbohydrates, proteins and fats. It is essential in Hb formation and GABA synthesis within the CNS. It also aids in the release of glycogen stored in the liver and muscles.', 'Additive effects with CNS depressants, neuroleptics, anticholinergics, alcohol.');

INSERT INTO generic VALUES(1464, 'Vitamin C (Ascorbic Acid)', 'Should be given with caution to patient with hyperoxaluria.', 'Treatment or prevention of Vitamin C Deficiency, Scurvy, Infection, Trauma, Burns, Cold exposure, Following Surgery, common cold, Fever, scurvy, Stress, Cancer, Methaemoglobinaemia
                           and Children receiving unfortified formulas. Also indicated in Hematuria, Dental Caries, Gum Diseases, Pyorrhea, Acne, Infertility, Atherosclerosis, Fractures, Leg ulcers, Hay fever, Vascular thrombosis prevention, Levodopa toxicity, Arsenic toxicity and etc.', NULL, 'Oral
Scurvy
Adult: Prevention: 25-75 mg daily. 4 tablets 2 to 3 times daily. Treatment: >250 mg daily, given in divided doses. May also be given via IM/IV/SC admin. 250-500mg IV qDay/BID  for at least 2 weeks.

Child: 1 mth-4 yr: 125-250 mg daily; 4-12 yr: 250-500 mg daily; 12-18 yr: 500 mg-1 g daily. Doses to be given in 1-2 divided doses.

Thalassaemia
Adult: 100-200 mg daily, to be given with desferrioxamine.
Child: 100-200 mg daily, to be given with desferrioxamine.

Metabolic disorders
Child: Neonate: 50-200 mg daily, adjust if needed; 1 mth-18 yr: 200-400 mg daily in 1-2 divided doses, up to 1 g daily may be needed.

Adult:
Common cold: 1 gm or more daily in divided doses, i.e. 4 tablets daily.
In wound healing: 2-4 tablets 2 to 3 times daily
In other conditions: 1-2 tablets daily

Children: < 4 years: 1/4 adult dose, 4-12 years: 1/2 of the adult dose.

1 effervescent tablet daily with a meal or as directed by physician. Dissolve one tablet in half glass (100 ml) of water and drink instantly.', 'Ascorbic acid does not seem to have any important adverse effects at dosages less than 4 mg/day.
                           Larger dose may cause diarrhoea or formation of renal calculi of calcium oxalate in patients with renal impairment. Ingestion of more than 600 mg daily have a diuretic action.', 'Vitamin C: Necessary for collagen
                           formation and tissue repair; plays a role in oxidation/reduction
                           reactions as well as other metabolic pathways
                           including synthesis of catecholamines,
                           carnitine, and steroids; also plays a role in conversion of folic acid to folinic acid.', 'Vit C: Deferroxamine, hormonal contraceptives, flufenazine,
                           warfarin, elemental iron, salicylates, warfarin, fluphenazine, disulfiram, mexiletine, vitamin B12.');

INSERT INTO brand VALUES(10, 386, 'Oyster Pharmaceuticals Ltd.', 'Xeoflox', 'Tablet', '500mg', 361.0, '30''s pack');

INSERT INTO brand VALUES(47, 538, 'Acme Laboratories Ltd.', 'A Fenac', 'Injection', '75mg/3ml', 140.6, '10 amps pack');

INSERT INTO brand VALUES(98, 336, 'Chemist Laboratories Ltd.', 'Abac', 'Paediatric Drops', '125mg/1.2ml', 50.0, '15ml bot');

INSERT INTO brand VALUES(109, 956, 'Monicopharma Limited', 'Ancliz', 'Tablet', NULL, 150.0, '50''s pack');

INSERT INTO brand VALUES(753, 650, 'Ibn Sina Pharmaceutical Ind. Ltd.', 'Algirex', 'Tablet', '120mg', 285.0, '20''s pack');

INSERT INTO brand VALUES(861, 61, 'Kemiko Pharmaceuticals Ltd.', 'Aloten 5/25', 'Tablet', NULL, 212.5, '50''s pack');

INSERT INTO brand VALUES(1439, 135, 'Square Pharmaceuticals Ltd.', 'Anclog PLUS', 'Tablet', '75 mg + 75 mg', 331.17, '30''s pack');

INSERT INTO brand VALUES(1724, 141, 'Square Pharmaceuticals Ltd.', 'Anzitor', 'Tablet', '10mg', 502.0, '50''s pack');

INSERT INTO brand VALUES(2031, 1464, 'Beximco Pharmaceuticals Ltd.', 'Ascobex', 'Tablet', '250mg', 264.0, '200''s pack');

INSERT INTO brand VALUES(4694, 489, 'Beximco Pharmaceuticals Ltd.', 'Cinarex-D', 'Eye Drops', NULL, 150.0, '5  ml drop');

INSERT INTO indication VALUES(2, 'Crohn''s disease');

INSERT INTO indication VALUES(17, 'Osteoarthritis / degenerative arthritis');

INSERT INTO indication VALUES(21, 'Musculoskeletal and joint pain');

INSERT INTO indication VALUES(31, 'Pneumonia');

INSERT INTO indication VALUES(83, 'Hypertension');

INSERT INTO indication VALUES(174, 'CAD');

INSERT INTO indication VALUES(260, 'TIA');

INSERT INTO indication VALUES(379, 'Bacterial eye infections');

INSERT INTO indication VALUES(714, 'Nausea and vomiting');

INSERT INTO indication VALUES(956, 'General weakness');

INSERT INTO indication_generic_index VALUES(336, 31);

INSERT INTO indication_generic_index VALUES(386, 2);

INSERT INTO indication_generic_index VALUES(538, 17);

INSERT INTO indication_generic_index VALUES(141, 174);

INSERT INTO indication_generic_index VALUES(650, 21);

INSERT INTO indication_generic_index VALUES(61, 83);

INSERT INTO indication_generic_index VALUES(1464, 956);

INSERT INTO indication_generic_index VALUES(135, 260);

INSERT INTO indication_generic_index VALUES(956, 714);

INSERT INTO indication_generic_index VALUES(489, 379);

INSERT INTO pharmacy_branch VALUES(1, 'Аптека «Здоровье» на Арбате', 'Москва', 'ул. Арбат, д. 24', '+7 (495) 555-01-01', '08:00', '22:00', 2012);

INSERT INTO pharmacy_branch VALUES(2, 'Аптека «Здоровье» на Тверской', 'Москва', 'ул. Тверская, д. 15', '+7 (495) 555-01-02', '00:00', '24:00', 2014);

INSERT INTO pharmacy_branch VALUES(3, 'Аптека «Здоровье» на Невском', 'Санкт-Петербург', 'Невский пр., д. 88', '+7 (812) 555-01-03', '09:00', '22:00', 2013);

INSERT INTO pharmacy_branch VALUES(4, 'Аптека «Здоровье» на Баумана', 'Казань', 'ул. Баумана, д. 35', '+7 (843) 555-01-04', '08:00', '21:00', 2016);

INSERT INTO pharmacy_branch VALUES(5, 'Аптека «Здоровье» на Ленина', 'Екатеринбург', 'ул. Ленина, д. 50', '+7 (343) 555-01-05', '08:00', '22:00', 2015);

INSERT INTO pharmacy_branch VALUES(6, 'Аптека «Здоровье» на Красном проспекте', 'Новосибирск', 'Красный пр., д. 100', '+7 (383) 555-01-06', '00:00', '24:00', 2017);

INSERT INTO pharmacy_branch VALUES(7, 'Аптека «Здоровье» на Большой Покровской', 'Нижний Новгород', 'ул. Большая Покровская, д. 22', '+7 (831) 555-01-07', '09:00', '21:00', 2018);

INSERT INTO pharmacy_branch VALUES(8, 'Аптека «Здоровье» на Красной', 'Краснодар', 'ул. Красная, д. 120', '+7 (861) 555-01-08', '08:00', '23:00', 2019);

INSERT INTO pharmacy_branch VALUES(9, 'Аптека «Здоровье» на Куйбышева', 'Самара', 'ул. Куйбышева, д. 66', '+7 (846) 555-01-09', '09:00', '21:00', 2020);

INSERT INTO pharmacy_branch VALUES(10, 'Аптека «Здоровье» на Пушкинской', 'Ростов-на-Дону', 'ул. Пушкинская, д. 40', '+7 (863) 555-01-10', '08:00', '22:00', 2021);

INSERT INTO employee VALUES(1, 'Иванова', 'Елена', 'Сергеевна', 'Заведующий аптекой', 1, '+7 (900) 555-01-11', '2015-03-02', 95000);

INSERT INTO employee VALUES(2, 'Петров', 'Алексей', 'Николаевич', 'Провизор', 1, '+7 (900) 555-01-12', '2018-09-17', 78000);

INSERT INTO employee VALUES(3, 'Смирнова', 'Ольга', 'Викторовна', 'Заведующий аптекой', 2, '+7 (900) 555-01-13', '2014-06-10', 98000);

INSERT INTO employee VALUES(4, 'Кузнецов', 'Дмитрий', 'Андреевич', 'Фармацевт', 2, '+7 (900) 555-01-14', '2020-02-24', 62000);

INSERT INTO employee VALUES(5, 'Попова', 'Анна', 'Игоревна', 'Провизор', 3, '+7 (900) 555-01-15', '2017-11-01', 80000);

INSERT INTO employee VALUES(6, 'Соколов', 'Михаил', 'Павлович', 'Заведующий аптекой', 4, '+7 (900) 555-01-16', '2016-05-23', 90000);

INSERT INTO employee VALUES(7, 'Лебедева', 'Мария', 'Александровна', 'Фармацевт', 5, '+7 (900) 555-01-17', '2021-08-09', 60000);

INSERT INTO employee VALUES(8, 'Новиков', 'Сергей', 'Владимирович', 'Кассир', 6, '+7 (900) 555-01-18', '2022-01-31', 52000);

INSERT INTO employee VALUES(9, 'Морозова', 'Екатерина', 'Дмитриевна', 'Провизор', 7, '+7 (900) 555-01-19', '2019-04-15', 76000);

INSERT INTO employee VALUES(10, 'Волков', 'Игорь', 'Олегович', 'Фармацевт', 8, '+7 (900) 555-01-20', '2023-03-06', 58000);

INSERT INTO receipt VALUES(1, 1, 2, '2026-10-26 10:15', 'Карта');

INSERT INTO receipt VALUES(2, 1, 2, '2026-10-27 18:40', 'Наличные');

INSERT INTO receipt VALUES(3, 2, 4, '2026-10-27 23:05', 'Карта');

INSERT INTO receipt VALUES(4, 2, 4, '2026-10-28 12:30', 'СБП');

INSERT INTO receipt VALUES(5, 3, 5, '2026-10-29 14:20', 'Наличные');

INSERT INTO receipt VALUES(6, 4, 6, '2026-10-29 09:10', 'Карта');

INSERT INTO receipt VALUES(7, 5, 7, '2026-10-30 16:45', 'СБП');

INSERT INTO receipt VALUES(8, 6, 8, '2026-10-31 02:30', 'Наличные');

INSERT INTO receipt VALUES(9, 7, 9, '2026-11-01 11:00', 'Карта');

INSERT INTO receipt VALUES(10, 8, 10, '2026-11-02 20:15', 'Карта');

INSERT INTO receipt_item VALUES(1, 1724, 2, 502.0);

INSERT INTO receipt_item VALUES(1, 10, 1, 361.0);

INSERT INTO receipt_item VALUES(2, 98, 1, 50.0);

INSERT INTO receipt_item VALUES(3, 2031, 1, 264.0);

INSERT INTO receipt_item VALUES(3, 1439, 2, 331.17);

INSERT INTO receipt_item VALUES(4, 1724, 1, 502.0);

INSERT INTO receipt_item VALUES(5, 753, 2, 285.0);

INSERT INTO receipt_item VALUES(5, 861, 1, 212.5);

INSERT INTO receipt_item VALUES(6, 861, 1, 212.5);

INSERT INTO receipt_item VALUES(6, 109, 1, 150.0);

INSERT INTO receipt_item VALUES(7, 47, 3, 140.6);

INSERT INTO receipt_item VALUES(8, 4694, 1, 150.0);

INSERT INTO receipt_item VALUES(9, 10, 2, 361.0);

INSERT INTO receipt_item VALUES(9, 98, 1, 50.0);

INSERT INTO receipt_item VALUES(10, 2031, 1, 264.0);

COMMIT;
