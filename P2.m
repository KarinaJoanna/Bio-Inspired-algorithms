ls = input ("What is the value of ls? ");
li = input("What is the value of li? ");
pres = input("What is the precision? ");
nind = input("what is the number of individuals? ");

%ls = 5;
%li = -5;
%pres = 3;

% Aleatorios
a = 0;
b = 1;
%nind = 5; % numero de individuos

% Funcion para calcular no. de bits para codificar un numero real 
% con "res" digitos de precision

bits = round(log((ls-li)*10^pres)+0.9)
p = randi([a b],nind,bits)

%%
% Funcion para decodificar una cadena de bits a numero real

valor = sum(2^k*bk+1)

R = li + (valor*(ls-li)/2^bits-1)

function output = decode_bits_to_real(bits)
    % Convertir la cadena de bits a un número entero
    num = bin2num(bits);
    
    % Normalizar el número para que esté en el rango de 0 a 1
    normalized_num = num / (2^length(bits) - 1);
    
    % Escalar y desplazar el número para que esté en el rango deseado
    output = (max_value - min_value) * normalized_num + min_value;
end

%decoded_num = decode_bits_to_real('11001100', -1, 1);