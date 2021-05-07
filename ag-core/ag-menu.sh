#!/bin/bash
rompath="$PWD"
vendor_path="ag"
temp_path="$rompath/vendor/$vendor_path/tmp"
config_type="$1"
modulepath="$rompath/vendor/$vendor_path/scripts"
privmodulepath="$rompath/vendor/$vendor_path/private-scripts"
source $rompath/vendor/$vendor_path/ag-core/gui/easybashgui

modules=$(cat $temp_path/modules.lst |tr "\n" " ")
privatemodules=$(cat $temp_path/priv-modules.lst |tr "\n" " ")

modulesString="$modules $privatemodules"
moduleStringArray=($modulesString)
# notify -t "Good tooltip:OK#Bad tooltip:BAD" -i "/usr/local/share/pixmaps/nm-signal-100.png#gtk-fullscreen" "Xclock" "xclock" "Xcalc" "xcalc"
#
while :
	do
	menu $modulesString
	answer=$(0< "${dir_tmp}/${file_tmp}" )
	#
	for i in $modulesString ; do
		if [ "${answer}" = "${i}" ]; then
			notify_message "Starting \"${i}\" ..."
			notify_change "${i}"
			
			echo -e ${reset}""${reset}
			echo -e ${teal}"${i}"${reset}
			echo -e ${reset}""${reset} 
			if [ -d $modulepath/${i} ];then
				bash $modulepath/${i}/${i}.sh $config_type
			elif [ -d $privmodulepath/${i} ];then
				bash $privmodulepath/${i}/${i}.sh $config_type
			fi
		fi
		
	done
	if [ "${answer}" = "" ]; then
		exit
	fi
	
	#~ if [ "${answer}" = "add-astian-apps" ]
		#~ then
		#~ notify_message "Starting \"add-astian-apps\" ..."
		#~ notify_change "add-astian-apps"
		
		#~ echo -e ${reset}""${reset}
		#~ echo -e ${teal}"add-astian-apps"${reset}
		#~ echo -e ${reset}""${reset} 
		#~ if [ -d $modulepath/add-astian-apps ];then
			#~ bash $modulepath/add-astian-apps/add-astian-apps.sh
		#~ elif [ -d $privmodulepath/add-astian-apps ];then
			#~ bash $privmodulepath/add-astian-apps/add-astian-apps.sh
		#~ fi
				
	#~ elif [ "${answer}" = "generate-base" ]
		#~ then
		#~ notify_message "Starting \"generate-base\" ..."
		#~ notify_change "generate-base"
		
		#~ echo -e ${reset}""${reset}
		#~ echo -e ${teal}"generate-base"${reset}
		#~ echo -e ${reset}""${reset} 
		#~ if [ -d $modulepath/generate-base ];then
			#~ bash $modulepath/generate-base/generate-base.sh
		#~ elif [ -d $privmodulepath/generate-base ];then
			#~ bash $privmodulepath/generate-base/generate-base.sh
		#~ fi
				
	#~ elif [ "${answer}" = "generate-others" ]
		#~ then
		#~ notify_message "Starting \"generate-others\" ..."
		#~ notify_change "generate-others"
		
		#~ echo -e ${reset}""${reset}
		#~ echo -e ${teal}"generate-others"${reset}
		#~ echo -e ${reset}""${reset} 
		#~ if [ -d $modulepath/generate-others ];then
			#~ bash $modulepath/generate-others/generate-others.sh
		#~ elif [ -d $privmodulepath/generate-others ];then
			#~ bash $privmodulepath/generate-others/generate-others.sh
		#~ fi
	#~ else
		#~ exit
	#~ fi
	
done



clean_temp #(since v.6.X.X this function is no more required if easybashlib is present and then successfully loaded by easybashgui)
