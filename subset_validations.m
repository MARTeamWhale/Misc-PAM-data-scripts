%subset_filter_validations.m
%subset a validations file by datetime and filter for number of
%NClicksBeaked_EventDet

clear
close all

%%% CHANGE AS NEEDED %%%

Path2Validations = "F:\BEAKED_WHALE_ANALYSIS\MGL_2019_10\results_SpeciesEvents\MGL_2019_10_Mb_Validated_hourly.xlsx";

Start_datetime = '2020-05-09T00:00:00';
End_datetime = '2020-05-14T00:00:00';

Nclick_thresehold = 1;

%%%%%%%%%%%%%%%%%%%%%%%%

Start_datetime = datetime(Start_datetime);
End_datetime = datetime(End_datetime);

validations = readtable(Path2Validations);

validation_subset = validations(datetime(validations.StartTime,"InputFormat",'yyyyMMdd''_''HHmmss')>=Start_datetime & ...
                                datetime(validations.EndTime,"InputFormat",'yyyyMMdd''_''HHmmss') < End_datetime & validations.NClicksBeaked_EventDet > Nclick_thresehold,:);



temp = split(Path2Validations,'.');
Path2Subset = strcat(temp(1),'_DTsubset2.',temp(2));

writetable(validation_subset,Path2Subset);