#!/bin/bash
#---------------------------------------------------------------------------------
# The statement below includes the batch path directories.

daily="/POO/fos/File_Ordering_Logs/Daily"
weekly="/POO/fos/File_Ordering_Logs/Weekly"
monthly="/POO/fos/File_Ordering_Logs/Semiannually"

spoolFilterDir="/POO/fos/spool_error_chk"

_endDate=$(date +"%m%d%Y")
_day=$(date +"%u")

#------------------------------------------------------------------------

case "$1" in
    (daily)
        directory=$daily
        _beginDate=$(date -d "1 day ago" +"%m%d%Y")
        report="$_endDate"DailyFOSReport".csv"
        ;;

    (weekly)
        directory=$weekly
        _beginDate=$(date -d "7 days ago" +"%m%d%Y")
        report="$_beginDate-$_endDate"WeeklyFOSReport".csv"
        ;;

    (monthly)
        directory=$monthly
        _beginDate=$(date -d "183 days ago" +"%m%d%Y")
        report="$_beginDate-$_endDate"SemiAnnualFOSReport".csv"
        ;;  
esac

touch "$spoolFilterDir/$report"

#------------------------------------------------------------------------
# Error filter
#
exec_error_filter()
{
    cd $spoolFilterDir
    
    grep --include "*.csv" -e "ERROR" -e^SELECT -e^TNS -e^SP2 -e^ORA ${spoolFilterDir}/${report}
    greprc=$?
    
    if [[ $greprc -eq 0 ]] ; then 
        echo "--------------------------------"
        echo "Erroneous data spooled to .csv report. Removing report."
        echo "--------------------------------"
        rm ${spoolFilterDir}/${report}
    
    else
        echo "FOS report successfully generated."
    fi  
    
    case "$1" in
        (daily)
            mv ${spoolFilterDir}/${report} $daily
            ;;
        (weekly)
            mv ${spoolFilterDir}/${report} $weekly
            ;;
        (monthly)
            mv ${spoolFilterDir}/${report} $monthly
            ;;
    esac
}

#-----------------------------------------------------------------------------
#END
