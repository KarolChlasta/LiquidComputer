float dt = 0.00005 // simulation time step in sec
setclock  0  {dt}  // set the simulation clock

int array_minx =  1     // najmniejszy indeks x
int array_miny =  1     // najmniejszy indeks y
int array_minz =  1     // najmniejszy indeks z

float sep_x = 40e-6     // odleglosc miedzy neuronami w kierunku x w metrach
float sep_y = 40e-6     // odleglosc miedzy neuronami w kierunku y w metrach
float sep_z = 40e-6     // odleglosc miedzy neuronami w kierunku z w metrach


include functions.g
include protodefs.g

readcell cell.p /cell

randseed

make_circuit_2d /cell /retina_net 10 10
make_circuit_2d_output /retina_net 10 10 rec-netRet100

make_circuit_3d /cell /column_net_1 8 8 16
make_circuit_3d_output /column_net_1 8 8 16 rec-netRet100-column1

make_circuit_3d /cell /column_net_2 8 8 16
make_circuit_3d_output /column_net_2 8 8 16 rec-netRet100-column2

make_circuit_3d /cell /column_net_3 8 8 16
make_circuit_3d_output /column_net_3 8 8 16 rec-netRet100-column3

make_circuit_3d /cell /column_net_4 8 8 16
make_circuit_3d_output /column_net_4 8 8 16 rec-netRet100-column4

int i1,j1,k1,i2,j2,k2,ri,rj

float probability = 0.01

for (i1=1; i1<=8; i1={i1+1})
 for (j1=1; j1<=8; j1={j1+1})
  for (k1=1; k1<=16; k1={k1+1})
   for (i2=1; i2<=8; i2={i2+1})
     for (j2=1; j2<=8; j2={j2+1})
       for (k2=1; k2<=16; k2={k2+1})

       if ( {rand 0 1} < {probability} )            
        make_synapse /column_net_1_{i1}_{j1}_{k1}/soma/spike \
                     /column_net_1_{i2}_{j2}_{k2}/dend/Ex_channel 3.8 0
       end

       if ( {rand 0 1} < {probability} )            
        make_synapse /column_net_2_{i1}_{j1}_{k1}/soma/spike \
                     /column_net_2_{i2}_{j2}_{k2}/dend/Ex_channel 3.8 0
       end

       if ( {rand 0 1} < {probability} )            
        make_synapse /column_net_3_{i1}_{j1}_{k1}/soma/spike \
                     /column_net_3_{i2}_{j2}_{k2}/dend/Ex_channel 3.8 0
       end

       if ( {rand 0 1} < {probability} )            
        make_synapse /column_net_4_{i1}_{j1}_{k1}/soma/spike \
                     /column_net_4_{i2}_{j2}_{k2}/dend/Ex_channel 3.8 0                     
       end
           
    end
   end
  end
 end
 end
end

for (i1=1; i1<=8; i1={i1+1})
 for (j1=1; j1<=8; j1={j1+1})
  for (k1=1; k1<=16; k1={k1+1})

  // połaczenie pola recepcyjnego nr 1 z kolumną kory nr 1

       for (ri=1; ri<=5; ri={ri+1})
       	for (rj=1; rj<=5; rj={rj+1})

         if ( {rand 0 1} < {probability} )            
          make_synapse /retina_net_{ri}_{rj}/soma/spike \
                       /column_net_1_{i1}_{j1}_{k1}/dend/Ex_channel 3.8 0
       	 end
       	end
       end

  // połaczenie pola recepcyjnego nr 2 z kolumną kory nr 2

       for (ri=6; ri<=10; ri={ri+1})
       	for (rj=1; rj<=5; rj={rj+1})

         if ( {rand 0 1} < {probability} )            
          make_synapse /retina_net_{ri}_{rj}/soma/spike \
                       /column_net_2_{i1}_{j1}_{k1}/dend/Ex_channel 3.8 0
       	 end
       	end
       end

  // połaczenia pola recepcyjnego nr 3 z kolumną kory nr 3

       for (ri=1; ri<=5; ri={ri+1})
       	for (rj=6; rj<=10; rj={rj+1})

         if ( {rand 0 1} < {probability} )            
          make_synapse /retina_net_{ri}_{rj}/soma/spike \
    		      /column_net_3_{i1}_{j1}_{k1}/dend/Ex_channel 3.8 0
       	 end
       	end
       end

  // połączenie pola recepcyjnego nr 4 z kolumną kory nr 4
  
       for (ri=6; ri<=10; ri={ri+1})
       	for (rj=6; rj<=10; rj={rj+1})

         if ( {rand 0 1} < {probability} )            
          make_synapse /retina_net_{ri}_{rj}/soma/spike \
                       /column_net_4_{i1}_{j1}_{k1}/dend/Ex_channel 3.8 0
       	 end
       	end
       end

  end
 end
end

// zmieniłem średnią częstość generatora pików potencjałów czynnościowych komórek układu wzrokowego na 220Hz
create randomspike /input
setfield ^ min_amp 1 max_amp 1 rate 200 reset 1 reset_value 0

// podłączenie generatora impulsów do kanałów wzbudzających siatkówki
make_synapse /input /retina_net_5_4/dend/Ex_channel 2 0
make_synapse /input /retina_net_5_5/dend/Ex_channel 2 0
make_synapse /input /retina_net_5_6/dend/Ex_channel 2 0
make_synapse /input /retina_net_5_7/dend/Ex_channel 2 0
make_synapse /input /retina_net_6_6/dend/Ex_channel 2 0
make_synapse /input /retina_net_6_7/dend/Ex_channel 2 0
make_synapse /input /retina_net_7_4/dend/Ex_channel 2 0
make_synapse /input /retina_net_7_7/dend/Ex_channel 2 0

reset
check

step 1 -time
quit
