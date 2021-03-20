# EU-DEM processing

Input data:

```
/mnt/repository/eu-dem/
├── eu_dem_v11_E40N20.TIF
├── eu_dem_v11_E40N30.TIF
```

## 1. Process input data

```
grass78 -c EPSG:3035 /mnt/repository/eu-dem/grassloc-3035 --exec ./import_3035.sh
```

## 2. Export output data

```
grass78 -c EPSG:5514 /mnt/repository/eu-dem/grassloc-5515 --exec ./export_5514.sh
```
