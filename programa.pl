% Aquí va el código.
herramientasRequeridas(ordenarCuarto, [[aspiradora(100), escoba], trapeador, plumero]).
herramientasRequeridas(limpiarTecho, [escoba, pala]).
herramientasRequeridas(cortarPasto, [bordedadora]).
herramientasRequeridas(limpiarBanio, [sopapa, trapeador]).
herramientasRequeridas(encerarPisos, [lustradpesora, cera, aspiradora(300)]).

% Punto 1

tiene(egon, aspiradora(200)).
tiene(egon, trapeador).
tiene(peter, trapeador).
tiene(winston, varita).

% Punto 2

satisfaceNecesidad(Persona, Herramienta):-
    tiene(Persona, Herramienta).

satisfaceNecesidad(Persona, aspiradora(PotenciaReq)):-
    tiene(Persona, aspiradora(Potencia)),
    Potencia >= PotenciaReq.

satisfaceNecesidad(Persona, Reemplazables):-
    tiene(Persona, Herramienta),
    member(Herramienta, Reemplazables).

% Punto 3

requiere(Tarea, Herramienta):-
    herramientasRequeridas(Tarea, Requeridas),
    member(Herramienta, Requeridas).

puedeRealizar(Persona, Tarea):-
    tiene(Persona,_),
    herramientasRequeridas(Tarea,_),
    forall(requiere(Tarea, Herramienta), satisfaceNecesidad(Persona, Herramienta)).

puedeRealizar(Persona, Tarea):-
    herramientasRequeridas(Tarea,_),
    tiene(Persona, varita).

% Punto 4

tareaPedida(thom, limpiarBanio, 5).

precio(limpiarBanio, 30).

pagaPorTarea(Cliente, Tarea, ACobrar):-
    tareaPedida(Cliente, Tarea, Metros),
    precio(Tarea, Precio),
    ACobrar is Precio * Metros.

cuantoPaga(Cliente, ACobrar):-
    tareaPedida(Cliente,_,_),
    findall(Precio, pagaPorTarea(Cliente, Tarea, Precio), ListaPrecios),
    sumlist(ListaPrecios, ACobrar).

% Punto 5

esCompleja(Tarea):-
    herramientasRequeridas(Tarea, Requeridas),
    length(Requeridas, Cantidad),
    Cantidad > 2.

esCompleja(limpiarTecho).

pideTareaCompleja(Cliente):-
    tareaPedida(Cliente, Tarea,_),
    esCompleja(Tarea).

aceptaPedido(ray, Cliente):-
    tareaPedida(Cliente,_,_),
    not(tareaPedida(Cliente, limpiarTecho,_)).

aceptaPedido(winston, Cliente):-
    cuantoPaga(Cliente, Precio),
    Precio > 500.

aceptaPedido(egon, Cliente):-
    tareaPedida(Cliente,_,_),
    not(pideTareaCompleja(Cliente)).

aceptaPedido(peter, Cliente):-
    tareaPedida(Cliente,_,_).
