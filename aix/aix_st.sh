#!/usr/bin/ksh
# Software populate
wget ftp://public.dhe.ibm.com/aix/freeSoftware/aixtoolbox/RPMS/ppc/screen/screen-3.9.10-2.aix4.3.ppc.rpm
wget ftp://public.dhe.ibm.com/aix/freeSoftware/aixtoolbox/RPMS/ppc/coreutils/coreutils-5.2.1-2.aix5.1.ppc.rpm
wget ftp://public.dhe.ibm.com/aix/freeSoftware/aixtoolbox/RPMS/ppc/grep/grep-2.5.1-1.aix4.3.ppc.rpm
wget ftp://public.dhe.ibm.com/aix/freeSoftware/aixtoolbox/RPMS/ppc/zsh/zsh-4.0.4-3.aix5.1.ppc.rpm
wget ftp://public.dhe.ibm.com/aix/freeSoftware/aixtoolbox/RPMS/ppc/less/less-382-1.aix5.1.ppc.rpm
wget ftp://public.dhe.ibm.com/aix/freeSoftware/aixtoolbox/RPMS/ppc/vim/vim-common-6.3-1.aix5.1.ppc.rpm
wget ftp://public.dhe.ibm.com/aix/freeSoftware/aixtoolbox/RPMS/ppc/vim/vim-enhanced-6.3-1.aix5.1.ppc.rpm
wget ftp://public.dhe.ibm.com/aix/freeSoftware/aixtoolbox/RPMS/ppc/gdbm/gdbm-1.8.3-5.aix5.2.ppc.rpm
wget ftp://public.dhe.ibm.com/aix/freeSoftware/aixtoolbox/RPMS/ppc/readline/readline-4.3-2.aix5.1.ppc.rpm

rpm -ivh screen-3.9.10-2.aix4.3.ppc.rpm
rpm -ivh coreutils-5.2.1-2.aix5.1.ppc.rpm
rpm -ivh grep-2.5.1-1.aix4.3.ppc.rpm
rpm -ivh zsh-4.0.4-3.aix5.1.ppc.rpm
rpm -ivh less-382-1.aix5.1.ppc.rpm
rpm -ivh vim-common-6.3-1.aix5.1.ppc.rpm
rpm -ivh vim-enhanced-6.3-1.aix5.1.ppc.rpm
rpm -ivh gdbm-1.8.3-5.aix5.2.ppc.rpm
rpm -ivh readline-4.3-2.aix5.1.ppc.rpm

