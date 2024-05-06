#!/bin/bash

apt install gcc-arm-linux-gnueabihf

mkdir /etc/xcompile
cd /etc/xcompile

echo "dir not found, installing"
mv /home/compilers/cross-compiler-i586.tar.bz2 ./
mv /home/compilers/cross-compiler-x86_64.tar.bz2 ./

tar -jxf cross-compiler-i586.tar.bz2
tar -jxf cross-compiler-x86_64.tar.bz2


rm *.tar.bz2
mv cross-compiler-i586 i586
mv cross-compiler-x86_64 x86_64

echo "Adding path variables in ~/.bashrc"
echo " " >> ~/.bashrc
echo "export PATH=\$PATH:/etc/xcompile/i586/bin" >> ~/.bashrc
echo "export PATH=\$PATH:/usr/local/go/bin" >> ~/.bashrc

echo "Done! please restart shell!"

#echo "Setting go path for dependecie install"
#export PATH=$PATH:/usr/local/go/bin
#export GOPATH=$HOME/Documents/go

#go get github.com/go-sql-driver/mysql
#go get github.com/mattn/go-shellwords

echo "Done! please restart shell!"
