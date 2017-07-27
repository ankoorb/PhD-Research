function [Op_rate]=OpLookupTable_all(moves_cate)

load Op_lookup_matrix.mat;

if moves_cate==1
    Op_rate=Op_rate1;
elseif moves_cate==2
    Op_rate=Op_rate2;
elseif moves_cate==3
    Op_rate=Op_rate3;
elseif moves_cate==4
    Op_rate=Op_rate4;
elseif moves_cate==5
    Op_rate=Op_rate5;
elseif moves_cate==6
    Op_rate=Op_rate6;
elseif moves_cate==7
    Op_rate=Op_rate7;
elseif moves_cate==8
    Op_rate=Op_rate8;
elseif moves_cate==9
    Op_rate=Op_rate9;
elseif moves_cate==10
    Op_rate=Op_rate10;
elseif moves_cate==11
    Op_rate=Op_rate11;
elseif moves_cate==12
    Op_rate=Op_rate12;
elseif moves_cate==13
    Op_rate=Op_rate13;
elseif moves_cate==14
    Op_rate=Op_rate14;
elseif moves_cate==16
    Op_rate=Op_rate16;
else
    Op_rate=Op_rate17;
end

                                                    
                                        
