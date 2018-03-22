#!/bin/csh

# =============================================================================
# This code reads output generated by airsea_diagnostics_DB.csh as applied
# to several different models or experiments.
#
# It plots mean fields in a single column using uniform contour intervals.
#
# A maximum of 8 panels is allowed.  For more panels, see 
#	AirSea_MultiModel_Plot_Means_2col.sh
#
# The model cases can be arranged any way the user choses, but it is envisioned
# that the first case be either OBS/reanalysis, or a control run.  Subsequent
# cases would then be results from different models or experiments. 
#
# Environmental variable "modelname" must match one of those listed in
# airsea_definitions_DB.sh
#
# The user specifies the output directory with the "setenv dirp" commend
# =============================================================================

setenv 	nCases			4		# requires one block per case, below
setenv	dirp			"/Users/demott/Projects/Coup_UnCoup/"		
#setenv	dirp			"/Users/demott/Dropbox/Work/"		
setenv	panelLabStrt	5		# adjust panel labeling:  0=a, 1=b, 2=c, etc.
setenv	plusOne			True

foreach var	( PRECT )

	foreach waveName ( ER KW KW_slow )

		setenv varName $var
		setenv waveType $waveName

		#----- case 0 ; 0-based indexing used in NCL, so we'll stick with that
		setenv 	diffname SPCCSM_minus_SPCAM3_mon
		set 	modelname=`echo $diffname | cut -d _ -f1`
		#echo 	$modelname
		source 	../airsea_definitions_DB.sh # handle model-specific logic
		setenv	caseName0	$modelname
		#echo 	$caseName0
		setenv 	MODDIR0		$FILEDIR"/proc/"$diffname"/"
		#echo	$MODDIR0
		setenv 	MODNAME0	$diffname
		#echo	$MODNAME0
	
		#----- case 1 ; 0-based indexing used in NCL, so we'll stick with that
		setenv 	diffname MetUM-GOML_minus_MetUM-ACM
		set 	modelname=`echo $diffname | cut -d _ -f1`
		#echo 	$modelname
		source 	../airsea_definitions_DB.sh # handle model-specific logic
		setenv	caseName1	$modelname
		#echo 	$caseName1
		setenv 	MODDIR1		$FILEDIR"/proc/"$diffname"/"
		#echo	$MODDIR1
		setenv 	MODNAME1	$diffname
		#echo	$MODNAME1
	
		#----- case 2 ; 0-based indexing used in NCL, so we'll stick with that
		setenv 	diffname ECHAM-CPL_minus_ECHAM-A31
		set 	modelname=`echo $diffname | cut -d _ -f1`
		#echo 	$modelname
		source 	../airsea_definitions_DB.sh # handle model-specific logic
		setenv	caseName2	$modelname
		#echo 	$caseName2
		setenv 	MODDIR2		$FILEDIR"/proc/"$diffname"/"
		#echo	$MODDIR2
		setenv 	MODNAME2	$diffname
		#echo	$MODNAME2
	
		#----- case 3 ; 3-based indexing used in NCL, so we'll stick with that
		setenv 	diffname CNRM-CM_minus_CNRM-ACM
		set 	modelname=`echo $diffname | cut -d _ -f1`
		#echo 	$modelname
		source 	../airsea_definitions_DB.sh # handle model-specific logic
		setenv	caseName3	$modelname
		#echo 	$caseName3
		setenv 	MODDIR3		$FILEDIR"/proc/"$diffname"/"
		#echo	$MODDIR3
		setenv 	MODNAME3	$diffname
		#echo	$MODNAME3
	
	
		ncl -Q ./plot_MultiModel_WaveType_DiffStdevs_1col.ncl
	end

end

