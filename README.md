# Batch Subset and Download of Gridded netCDF Data - Daymet Example

- *Author: ORNL DAAC*
- *Date: November 5, 2018*
- *Contact for ORNL DAAC: uso@daac.ornl.gov*

**Keywords: web service, netCDF, RESTful API, Daymet, THREDDS, NCSS**

## Overview

Example bash scripts are provided that automate spatial and/or temporal subsetting and download of netCDF files within a bounding box of longitude and latitude. This example queries Daymet daily gridded data. This capability is available through a THREDDS Data Server with an integrated NetCDF Subset Service (NCSS) using a RESTful API. Interactive requests can be automated through programmatic, machine-to-machine requests which involve the construction and submission of an HTTP request to the THREDDS data server through an extended URL with defined parameters. Further automation is possible with a downloading agent such as Wget. Subsets are returned in CF-compliant netCDF formats.

![NCSS in GSMNP LCC with minimum bounding geometry](NCSS_GSMNP_LCCboundingbox_withMinimumBoundingGeometry.png)

## Source Data

- North American Daymet Files: https://thredds.daac.ornl.gov/thredds/catalog/ornldaac/1328/catalog.html
- All Daymet Data in THREDDS: https://thredds.daac.ornl.gov/thredds/catalogs/ornldaac/Regional_and_Global_Data/DAYMET_COLLECTIONS/DAYMET_COLLECTIONS.html
- Daymet Web Site: https://daymet.ornl.gov/
- ORNL DAAC THREDDS Datasets: https://thredds.daac.ornl.gov/thredds/catalog.html

## Additional Information

Documentation of UNIDATA's netCDF Subset Service: https://www.unidata.ucar.edu/software/thredds/current/tds/reference/NetcdfSubsetServiceReference.html

## Prerequisites

A download client such as Wget or cURL is required

## Procedure

Download or copy the NCSS bash script of interest into a text editor

## Example Usage

1. Download the shell script
2. Open the file in a text editor and update the variables as directed in the header
3. If necessary, update the download client to your specifications
4. Save and Run the script. Generally this is done command line by entering, for example, "./NCSS_subset_fullyear.sh"

## Download Size Limits

The current Daymet NCSS has a size limit of 6GB for each single subset request. NCSS subset requests that result in data - exceeding this size limit will return an error message, instead of the actual subset data.

## Understanding the NCSS REST API

Visit the Web Services page for further description of THREDDS, the NCSS GUI, and an explanation of bounding box results.
In general, all Daymet data granules available through the NCSS follow this URL pattern:

    https://thredds.daac.ornl.gov/thredds/ncss/grid/ornldaac/1328/[YEAR]/daymet_v3_[DAYMETVAR]_[YEAR]_[region].nc4

Where DAYMETVAR is:

    Variable 	Description (units)
    tmax 	Daily maximum 2-meter air temperature (°C)
    tmin 	Daily minimum 2-meter air temperature (°C)
    prcp 	Daily total precipitation (mm/day)
    srad 	Incident shortwave radiation flux density (W/m2)
    vp 	Water vapor pressure (Pa)
    swe 	Snow water equivalent (kg/m2)
    dayl 	Duration of the daylight period (seconds/day)

YEAR is:

    1980 - most recent full calendar year

region is:

    na (North America)

A full URL standard request from the NCCS service will involve the following parameters:

    https://thredds.daac.ornl.gov/thredds/ncss/ornldaac/1328/1988/daymet_v3_[DAYMETVAR]_[YEAR]_[region].nc4?var=lat&var=lon&var=tmin&north=&west=&east=9&south=&disableProjSubset=on&horizStride=1&time_start=Z&time_end=&timeStride=&accept=netcdf

Where Parameters are:

    Parameter 	Description
    north 	The northern extent of the bounding box (latitude in decimal degrees) of the subset
    west 	The western extent of the bounding box (longitude in decimal degrees) of the subset
    east 	The eastern extent of the bounding box (longitude in decimal degrees) of the subset
    south 	The southern extent of the bounding box (latitude in decimal degrees) of the subset
    horizStride 	Will take every nth point (in both x and Y) of the gridded dataset. The default, "1", will take every point
    time_start 	The beginning of the time range. Specify a time range subset in the form: yyyy '-' mm '-' dd 'T' hh ':' mm ':' ss Z
    time_end 	The end of the time range. Specify a time range subset in the form: yyyy '-' mm '-' dd 'T' hh ':' mm ':' ss Z
    timeStride 	Will take only every nth time in the available series on gridded datasets. The default, "1", will take every time step
    accept 	The format of the subset data returned by the NCSS: "netcdf" for netCDF v3 format is the only option currently available