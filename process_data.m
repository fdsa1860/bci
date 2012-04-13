function ym=process_data(data)
% input: data, 17 x 89600
% output: ym
ChSel=1;
trig = data(17,:);
y=data(ChSel,:);
ym=y(307:1234)';
ym=ym/sqrt(ym'*ym);
ym=ym(1:266);

end