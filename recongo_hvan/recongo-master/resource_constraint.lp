weight(1,2). weight(2,3). weight(3,1). weight(4,4).
weight(5,2). weight(6,5). weight(7,1). weight(8,3).


% không được vượt quá 10 đơn vị tài nguyên.
:- active(X, T), #sum{ W,V : active(V, T), weight(V, W) } > 10.
