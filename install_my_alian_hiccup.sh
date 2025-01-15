#!/bin/bash

function echo_info()
{
	(>&2 echo "[info] $@")
}
export -f echo_info

function echo_warning()
{
	(>&2 echo -e "\033[1;93m$@ \033[0m")
}
export -f echo_warning

function echo_error()
{
	(>&2 echo -e "\033[1;31m$@ \033[0m")
}
export echo_error

function echo_note_red()
{
	(>&2 echo -e "\033[1;31m[note] $@ \033[0m")
}
export echo_note_red

function note_red()
{
	(>&2 echo -e "\033[1;31m[note] $@ \033[0m")
}
export -f note_red

function separator()
{
	echo -e "\033[1;32m$(padding "[ ${1} ]" "-" 50 center) \033[0m"
	## colors at http://misc.flogisoft.com/bash/tip_colors_and_formatting
}
export -f separator

function echo_note()
{
	echo_warning "$(padding "[note] ${@}" "-" 10 left)"
}
export -f echo_note

function note()
{
	echo_warning "$(padding "[note] ${@}" "-" 10 left)"
}
export -f note

function warning()
{
	echo_warning "[warning] $(padding "[${@}] " "-" 40 right)"
}
export -f warning

function error()
{
	echo_error "[error] $(padding "[${@}] " "-" 42 right)"
}
export -f error

function padding ()
{
	CONTENT="${1}";
	PADDING="${2}";
	LENGTH="${3}";
	TRG_EDGE="${4}";
	case "${TRG_EDGE}" in
		left) echo ${CONTENT} | sed -e :a -e 's/^.\{1,'${LENGTH}'\}$/&\'${PADDING}'/;ta'; ;;
		right) echo ${CONTENT} | sed -e :a -e 's/^.\{1,'${LENGTH}'\}$/\'${PADDING}'&/;ta'; ;;
		center) echo ${CONTENT} | sed -e :a -e 's/^.\{1,'${LENGTH}'\}$/'${PADDING}'&'${PADDING}'/;ta'
	esac
	return ${RET__DONE};
}
export -f padding

function check_exit_status()
{
	if [ $? -ne 0 ]; then
		error "The last command did not execute successfully. Exiting..."
		exit 1
	fi
}
export -f check_exit_status

separator "Setting up myalian"
workdir=/software/users/$USER/myalian
mkdir -pv $workdir
check_exit_status

separator "Setting up yaspenv"
cd $workdir && check_exit_status
git clone https://github.com/matplo/yasp.git && check_exit_status
yaspenv=${workdir}/yasp/yaspenv.sh

separator "Working within yaspenv"

separator "pip install some..."
${yaspenv} python -m pip install numpy tqdm pyyaml
module use /software/users/ploskon/yasp/software/modules/bundle
module load hepbase 

separator "install heppyy"
${yaspenv} module list
${yaspenv} cd $workdir && git clone https://github.com/matplo/heppyy.git
${yaspenv} ${workdir}/heppyy/install_with_yasp.sh

separator "install alian"
${yaspenv} module list
# ${yaspenv} cd $workdir && git clone https://github.com/matplo/alian.git
${yaspenv} cd $workdir && git clone git@github.com:matplo/alian.git
${yaspenv} "module load heppyy/current; ${workdir}/alian/install_with_yasp.sh"
${yaspenv} "python -m pip install -r ${workdir}/alian/alian/sandbox/requirements.txt"


separator "running a test..."
${yaspenv} "module load heppyy/current alian/current; ${workdir}/alian/alian/sandbox/jet_axis/pythia_jet_axis.py"

separator "done"