#written by: GIOVANNI GUARNIERI SOARES
#script to prepare a box with the graphene and water/ions, and run a npt and nvt ensamble on it.
x2top -f grafeno_circ_1.pdb -o grafeno_circ_1.top -ff amber99sb

editconf -f grafeno_circ_1.pdb -o grafeno_circ_center.pdb -box  3.8123 3.6639 6.0 

genbox -cp grafeno_circ_center.pdb -cs spc216.gro -o grafeno_circ_water.pdb -p grafeno_circ_1.top

#sed -i s/UNK/LIG/g grafeno_circ_water.pdb
#sed -i s/X//g grafeno_circ_water.pdb
#sed -i s/UNK/LIG/g grafeno_circ_1.top
#sed -i s/ICE/LIG/g grafeno_circ_1.top
#sed -i s/"ffamber99sb.itp"/"ffamber_ions.itp"/g grafeno_circ_1.top
#sed -i s/"; Include forcefield parameters"/"#include \"ffamber99sb.itp\""/g grafeno_circ_1.top
#grompp -f ../mdp/optimize.mdp -c grafeno_circ_water.pdb -p grafeno_circ_1.top -o grafeno_circ_opt.tpr
#
#mdrun -s grafeno_circ_opt.tpr -c grafeno_circ_opt.pdb -o grafeno_circ_opt.trr -g opt.log
##aqui adiciona o ion, acho que você não precisa
##genion -s grafeno_circ_opt.tpr -p grafeno_circ_1.top -o grafeno_circ_ion.pdb -neutral -conc 0.2 -pname Na -nname Cl
#
#grompp -f ../mdp/npt.mdp -c grafeno_circ_ion.pdb -p grafeno_circ_1.top -o grafeno_circ_npt.tpr -maxwarn 2
#
#mdrun -s grafeno_circ_npt.tpr -c grafeno_circ_npt.pdb -o grafeno_circ_npt.trr -g npt.log 
#
#grompp -f ../mdp/nvt.mdp -c grafeno_circ_npt.pdb -p grafeno_circ_1.top -o grafeno_circ_nvt.tpr -maxwarn 2
#
#mdrun -s grafeno_circ_nvt.tpr -c grafeno_circ_nvt.pdb -o grafeno_circ_nvt.trr -g nvt.log 

