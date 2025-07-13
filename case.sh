case "$VAR" in
  [qQ] )
        echo "Quit"
        ;;
  [yY]es | "YES" )
        echo "Yes"
        ;;
  [nN]o | "NO" )
        echo "No"
        ;;
  *) 
      echo "etc"
        ;;
esac
