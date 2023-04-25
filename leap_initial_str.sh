## this code generates the initial closed pdb and topology from the structure coming from cgNA+sugar and cgNA+min
## Need to change of number of bp in minicircle

lseq=94
RUNNAME='minicircle_MD'
INDEX='1'


rm leap.log
cp template.leap.1 leap.1.in

sed -i.original 's/XX1/1/g' leap.1.in
sed -i.original "s/YY1/${lseq}/g" leap.1.in
sed -i.original "s/XX2/$[lseq+1]/g" leap.1.in
sed -i.original "s/YY2/$[lseq+lseq]/g" leap.1.in

tleap -f leap.1.in

rm tmp.pdb *.original


NWat=$(grep "O   WAT" solvated.pdb  | wc -l )
Nions=$((15*NWat/5500))

echo Number of water ${NWat} and at 0.15 molarity Nions  ${Nions}

cp template.leap.2 leap.2.in


sed -i.original "s/UUUU/${Nions}/g" leap.2.in

tleap -f leap.2.in

rm *.original

cp template.traj traj.1.in

cpptraj traj.1.in


cp solvated.randions.crd ${RUNNAME}.crd 
cp solvated.randions.pdb ${RUNNAME}.pdb       
cp solvated.ions.top ${RUNNAME}.top       

cp solvated.randions.crd ${RUNNAME}_${INDEX}.crd       
cp solvated.randions.pdb ${RUNNAME}_${INDEX}.pdb
cp solvated.ions.top ${RUNNAME}_${INDEX}.top    


