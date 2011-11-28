function y=denoise(x,filter_en,bandwidth,htlsn_en,htlsn_order)

if nargin == 1
    filter_en = true;
    bandwidth = 1/8;
    htlsn_en = false;
    htlsn_order = [];
elseif nargin == 2;
    bandwidth = 1/8;
    htlsn_en = false;
    htlsn_order = [];
elseif nargin == 3
    htlsn_en = flase;
    htlsn_order = [];
elseif nargin == 4
    htlsn_order = 10;
end

L = size(x,1);

if filter_en == true
    v = fft(x);    
    h = ones(L,1);
    h(round(L*bandwidth):L-round(L*bandwidth)) = 0;
    y = v.*repmat(h,1,size(x,2));
    y = real(ifft(y));    
end

if htlsn_en==true
    if filter_en == true
        x = y;
    end
    for i=1:size(x,2)
        [yph,eta,xi] = hstln_mo(x(:,i)',htlsn_order);
        yph=yph';
        %         keyboard;
        y(:,i)=yph;
        fprintf('Finished HTLSN of the %dth of all %d data\n',i,L);
    end
end

end