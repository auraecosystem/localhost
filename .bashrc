function bkp() {
 N=0;
 DATE=$( /bin/date +%Y%m%d );
 for i in $@ ; do
  D=$( /usr/bin/dirname $i );
  F=$( /bin/echo $i | /bin/sed -e 's/.*\///g' );
  if [ ! -d $D/old ] ; then
   /bin/mkdir -p $D/old;
  fi ;
  until [ 1 -eq 2 ] ; do
   let “N += 1″;
   C=$( /usr/bin/printf “%s/old/%s-%s-%.2d-%s” $D $F $DATE $N $USER );
   if [ ! -f $C ] ; then
    break ;
   fi ;
  done ;
  /bin/cp -p $i $C;
 done;
}

