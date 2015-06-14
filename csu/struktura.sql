\echo start

CREATE SCHEMA :schema;

SET SEARCH_PATH TO :schema;

CREATE TABLE seznam_uzemi (
   id_uzemi varchar(15) primary key
   , cis int
   , kodzaz int
   , typuz_naz varchar(25)
   , nazev text
   , kodnuts varchar(20)
   , id_orp varchar(15)
   , id_okres varchar(15)
   , id_kraj varchar(15)
);

CREATE TABLE sldb (
   typuz_naz varchar(25)
   , nazev varchar(250) --primary key --peknej hnus delat retezec jako primar key
   , uzcis int
   , uzkod int --primary key
   , vse1111 float
   , vse1112 float
   , vse1113 float
   , vse1121 float
   , vse1122 float
   , vse1123 float
   , vse1131 float
   , vse1132 float
   , vse1133 float
   , vse1141 float
   , vse1142 float
   , vse1143 float
   , vse1151 float
   , vse1152 float
   , vse1153 float
   , vse2111 float
   , vse2112 float
   , vse2113 float
   , vse2121 float
   , vse2122 float
   , vse2123 float
   , vse2131 float
   , vse2132 float
   , vse2133 float
   , vse2141 float
   , vse2142 float
   , vse2143 float
   , vse2151 float
   , vse2152 float
   , vse2153 float
   , vse2161 float
   , vse2162 float
   , vse2163 float
   , vse2171 float
   , vse2172 float
   , vse2173 float
   , vse2181 float
   , vse2182 float
   , vse2183 float
   , vse3111 float
   , vse3112 float
   , vse3113 float
   , vse3121 float
   , vse3122 float
   , vse3123 float
   , vse3131 float
   , vse3132 float
   , vse3133 float
   , vse3141 float
   , vse3142 float
   , vse3143 float
   , vse3151 float
   , vse3152 float
   , vse3153 float
   , vse3161 float
   , vse3162 float
   , vse3163 float
   , vse3171 float
   , vse3172 float
   , vse3173 float
   , vse3181 float
   , vse3182 float
   , vse3183 float
   , vse3191 float
   , vse3192 float
   , vse3193 float
   , vse31101 float
   , vse31102 float
   , vse31103 float
   , vse31111 float
   , vse31112 float
   , vse31113 float
   , vse4111 float
   , vse4112 float
   , vse4113 float
   , vse4121 float
   , vse4122 float
   , vse4123 float
   , vse4131 float
   , vse4132 float
   , vse4133 float
   , vse4141 float
   , vse4142 float
   , vse4143 float
   , vse4151 float
   , vse4152 float
   , vse4153 float
   , vse4161 float
   , vse4162 float
   , vse4163 float
   , vse4171 float
   , vse4172 float
   , vse4173 float
   , vse4181 float
   , vse4182 float
   , vse4183 float
   , vse4191 float
   , vse4192 float
   , vse4193 float
   , vse41101 float
   , vse41102 float
   , vse41103 float
   , vse41111 float
   , vse41112 float
   , vse41113 float
   , vse5111 float
   , vse5112 float
   , vse5113 float
   , vse5121 float
   , vse5122 float
   , vse5123 float
   , vse5131 float
   , vse5132 float
   , vse5133 float
   , vse5141 float
   , vse5142 float
   , vse5143 float
   , vse5151 float
   , vse5152 float
   , vse5153 float
   , vse5161 float
   , vse5162 float
   , vse5163 float
   , vse5171 float
   , vse5172 float
   , vse5173 float
   , vse5181 float
   , vse5182 float
   , vse5183 float
   , vse5191 float
   , vse5192 float
   , vse5193 float
   , vse51101 float
   , vse51102 float
   , vse51103 float
   , vse6111 float
   , vse6112 float
   , vse6113 float
   , vse6121 float
   , vse6122 float
   , vse6123 float
   , vse6131 float
   , vse6132 float
   , vse6133 float
   , vse6141 float
   , vse6142 float
   , vse6143 float
   , vse6151 float
   , vse6152 float
   , vse6153 float
   , vse6161 float
   , vse6162 float
   , vse6163 float
   , vse6171 float
   , vse6172 float
   , vse6173 float
   , vse6181 float
   , vse6182 float
   , vse6183 float
   , vse6191 float
   , vse6192 float
   , vse6193 float
   , vse61101 float
   , vse61102 float
   , vse61103 float
   , vse61111 float
   , vse61112 float
   , vse61113 float
   , vse61121 float
   , vse61122 float
   , vse61123 float
);


CREATE TABLE polozky (
   polozka varchar(15) primary key
   , vyznam varchar(255)
   , poznamka text
);

CREATE INDEX ON sldb (uzkod);

CREATE INDEX ON sldb USING hash (uzcis);

--hash protoze je tam jen par hodnot

--DOPLNIM index do ruian obci


CREATE INDEX ON ruian.obce (kod);
