#!/bin/sh
set -e -x

mysql -uroot -ppassword openmrs < deidentify_openmrs.sql
