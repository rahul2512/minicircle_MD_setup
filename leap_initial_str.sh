## this code generates the initial closed pdb and topology from the structure coming from cgNA+sugar and cgNA+min
## Need to change of number of bp in minicircle

lseq=94
RUNNAME='minicircle_MD'
INDEX='1'


rm leap.log
cp template.leap.1 leap.1.in

sed -i 's/XX1/1/g' leap.1.in
sed -i "s/YY1/${lseq}/g" leap.1.in
sed -i "s/XX2/$[lseq+1]/g" leap.1.in
sed -i "s/YY2/$[lseq+lseq]/g" leap.1.in

/work/scitas-share/ddossant/amber/20/gcc-8.4.0-cuda-10.2/amber20/bin/tleap -f leap.1.in

rm tmp.pdb


NWat=$(grep "O   WAT" solvated.pdb  | wc -l )
Nions=$((15*NWat/5500))

echo Number of water ${NWat} and at 0.15 molarity Nions  ${Nions}

cp template.leap.2 leap.2.in


sed -i "s/UUUU/${Nions}/g" leap.2.in

/work/scitas-share/ddossant/amber/20/gcc-8.4.0-cuda-10.2/amber20/bin/tleap -f leap.2.in

cp template.traj traj.1.in

/work/scitas-share/ddossant/amber/18/gcc-7.4.0/bin/cpptraj traj.1.in


cp template.leap.3 leap.3.in
/work/scitas-share/ddossant/amber/20/gcc-8.4.0-cuda-10.2/amber20/bin/tleap -f leap.3.in


cp solvated.randions.crd ${RUNNAME}.crd 
cp solvated.randions.pdb ${RUNNAME}.pdb       
cp solvated.ions.top ${RUNNAME}.top       

cp solvated.randions.crd ${RUNNAME}_${INDEX}.crd       
cp solvated.randions.pdb ${RUNNAME}_${INDEX}.pdb
cp solvated.ions.top ${RUNNAME}_${INDEX}.top    

## final step might be reuqired if it gives error "Box info not found" -- otherwise not important

tail -1 solvated.crd >> ${RUNNAME}.crd
tail -1 solvated.crd >> ${RUNNAME}_${INDEX}.crd

