#written by: GIOVANNI GUARNIERI SOARES
#script to prepare a box with the graphene and water/ions, and run a npt and nvt ensamble on it.

#the script works to a graphene sheet in the xy plane

x2top -f grafeno_XXX.pdb -o grafeno_XXX.top -ff amber99sb

editconf -f grafeno_XXX.pdb -o grafeno_XXX_center.pdb -box  3.8123 3.6639 6.0 

genbox -cp grafeno_XXX_center.pdb -cs spc216.gro -o grafeno_XXX_water.pdb -p grafeno_XXX.top

sed -i s/UNK/LIG/g grafeno_XXX_water.pdb
sed -i s/X//g grafeno_XXX_water.pdb
sed -i s/UNK/LIG/g grafeno_XXX.top
sed -i s/ICE/LIG/g grafeno_XXX.top
sed -i s/"ffamber99sb.itp"/"ffamber_ions.itp"/g grafeno_XXX.top
sed -i s/"; Include forcefield parameters"/"#include \"ffamber99sb.itp\""/g grafeno_XXX.top

grompp -f ../mdp/optimize.mdp -c grafeno_XXX_water.pdb -p grafeno_XXX.top -o grafeno_XXX_opt.tpr
mdrun -s grafeno_XXX_opt.tpr -c grafeno_XXX_opt.pdb -o grafeno_XXX_opt.trr -g opt.log

genion -s grafeno_XXX_opt.tpr -p grafeno_XXX.top -o grafeno_XXX_ion.pdb -neutral -conc 0.2 -pname Na -nname Cl

grompp -f ../mdp/npt.mdp -c grafeno_XXX_ion.pdb -p grafeno_XXX.top -o grafeno_XXX_npt.tpr -maxwarn 2
mdrun -s grafeno_XXX_npt.tpr -c grafeno_XXX_npt.pdb -o grafeno_XXX_npt.trr -g npt.log 

grompp -f ../mdp/nvt.mdp -c grafeno_XXX_npt.pdb -p grafeno_XXX.top -o grafeno_XXX_nvt.tpr -maxwarn 2
mdrun -s grafeno_XXX_nvt.tpr -c grafeno_XXX_nvt.pdb -o grafeno_XXX_nvt.trr -g nvt.log 

grompp -f ../mdp/field.mdp -c grafeno_XXX_nvt.pdb -p grafeno_XXX.top -o grafeno_XXX_field.tpr -maxwarn 2
mdrun -s grafeno_XXX_field.tpr -c grafeno_XXX_field.pdb -o grafeno_XXX_field.trr -g field.log

