% This code is for BCI data processing project
% Hankel Angle is utilized to classify training data
clc;clear;close all;
%% read data
% [ym,labels,data]=read_binary_data();   % read data and labels
[ym,labels,data]=read_binary_data(4);   % read data and labels
% labels1=labels;
% load bcidata_filter0125_htlsn10;

% load bcidata_0315_SRPCA_HSTLN_manually_selected.mat;
% load bcidata_SRPCA0315_5_1000_first26data;

% load bcidata_lowpass_25Hz;
% load bcidata_lowpass_25Hz_SRPCA_5_100000;
% load bcidata_lowpass_25Hz_SRPCA_5_100000_HSTLN_10;

numLabels=numel(unique(labels));
FILTER_EN=1;    %enable or disable low pass filter
SEL_EN=1;    %enable or disable selection
SRPCA_EN=0;     %enable or disable SRPCA outlier cleaner
HSTLN_EN=0;     %enable or disable HSTLN order reduction



% for i=1:size(ym,2)
%     figure(1);
%     plot(ym(:,i),'r');
%     hold on;
% %     plot(real(ymF(:,i)),'k');
%     plot(ymR(:,i),'b');
%     plot(ymH(:,i),'g');
%     hold off;
% %     figure(2);
% %     plot(abs(fftshift(fft(ym(:,i)))),'r');
% %     hold on;
% %     plot(abs(fftshift(fft(ymR(:,i)))),'b');
% %     plot(abs(fftshift(fft(ymH(:,i)))),'g');
% %     hold off;
%     i
%     pause;
% end
% keyboard;
%% Lowpass filter
if FILTER_EN==1
    B=25;
    F=ones(size(ym,1),1);
    F(1+B:length(F)-B)=0;
    for i=1:size(ym,2)
        Y(:,i)=fft(ym(:,i)).*F;
        ymF(:,i)=real(ifft(Y(:,i)));    % not a good filter
%         figure(1);
%         plot(ym(:,i),'r');hold on;        
%         plot(real(ymF(:,i)),'k');
%         hold off;
%         figure(2);
%         plot(abs(fftshift(fft(ym(:,i)))),'r');
%         hold on;
%         plot(abs(fftshift(fft(ymF(:,i)))),'k');
%         hold off;
%         pause;
    end
    %     keyboard;
end
%% Select only the good data
if SEL_EN
    Ind=ones(size(ymF,2),1);
    parfor i=1:size(ymF,2)
        if norm(ymF(:,i),inf)>50
            Ind(i)=0;
        end
    end
end

%% SRPCA
if SRPCA_EN==1
    % x=ym(:,1);
    % for i=1:length(eInd)
    for i=1:size(ym,2)
        tic
        % ymR(:,i)=SRPCA_e1_e2_clean(ym(:,i),4.44,1000,ones(size(x)));
        ymR(:,i)=SRPCA_e1_e2_clean(ymF(:,i),5,100000,ones(size(ym,1),1));
        %     ymR(:,i)=SRPCA_e1_e2_clean(ym(:,eInd(i)),7,100000,ones(size(ym(:,eInd(i)))));
        
        %     y1=SRPCA_e1_e2_clean(ym(:,i),4.34,100000,ones(size(x)));
        %     y2=SRPCA_e1_e2_clean(ym(:,i),4.34,1000,ones(size(x)));
        %     y3=SRPCA_e1_e2_clean(ym(:,i),5,1000,ones(size(x)));
        %     hold on;plot(ym(:,i),'r');plot(y1,'b');  plot(y2,'g');plot(y3,'k');hold off;
        figure(1);
        plot(ym(:,i),'r');hold on;   plot(ymF(:,i),'k'); plot(ymR(:,i),'b');hold off;
        %     plot(ym(:,eInd(i)),'b');hold on;   plot(ymR(:,i),'r');hold off;
        toc
        fprintf('processing %d th data\n',i);
    end
    % errlabels=labels(eInd);
    % save bcidata_0322_SRPCA_7_100000_errData ymR errlabels;
    % keyboard;
    save bcidata_0328_lowpass_25Hz_SRPCA_5_100000_dat4 ymR labels;
end
load bcidata_0328_lowpass_25Hz_SRPCA_5_100000_dat4;
    
    % ymR(:,1)=SRPCA_e1_e2_clean(ym(:,1),4.34,100000,ones(size(x)));
    % ymR(:,2)=SRPCA_e1_e2_clean(ym(:,2),4.34,100000,ones(size(x)));
    % ymR(:,3)=SRPCA_e1_e2_clean(ym(:,3),5,100000,ones(size(x)));
    % ymR(:,14)=SRPCA_e1_e2_clean(ym(:,14),5,100000,ones(size(x)));


%% denoise, order reduction
if HSTLN_EN==1
    for i=1:size(ymR,2)
        [yph,eta,x] = hstln_mo(ymR(:,i)',10);
        hold on;
        % plot(ym(:,eInd(i)),'r');
        plot(ym(:,i),'r');
        plot(ymF(:,i),'k');
        hold off;
        yph=yph';
        % keyboard;
        ymH(:,i)=yph;
    end
    save bcidata_0328_lowpass_25_SRPCA_5_100000_HSTLN_10_dat4 ymH labels;
    % keyboard;
end
load  bcidata_0328_lowpass_25_SRPCA_5_100000_HSTLN_10_dat4;
    % %%
    % % yH1 = hstln_mo(ymR(:,1)',10)';
    % % yH2 = hstln_mo(ymR(:,2)',10)';
    % % yH3 = hstln_mo(ymR(:,3)',10)';
    % % yH4 = hstln_mo(ymR(:,14)',10)';



%% mask out bad data
mask=Ind;
ym=ym(:,mask==1);
ymF=ymF(:,mask==1);
ymR=ymR(:,mask==1);
ymH=ymH(:,mask==1);
labels=labels(:,mask==1);

%% plot data
% for i=1:size(ym,2)
%     figure(1);
%     plot(ym(:,i),'r');
%     hold on;
% %     plot(real(ymF(:,i)),'k');
%     plot(ymR(:,i),'b');
%     plot(ymH(:,i),'g');
%     fprintf('i=%d,label=%d\n',i,labels(i));
%     hold off;
%     pause;
% end

% ym=ymH;
fprintf('data acquired\n');

% for k=1:13
% for j=12:233

x1=ymF(:,labels==1);
U1=[];
for k=1:size(x1,2)
    H1=hankel_mo(x1(:,k)',[7*size(x1(:,k),2),size(x1,1)-7+1])';
    [U,S,V]=svd(H1);
    U1=[U1 U(:,1:7)];
end
[U11,S,V]=svd(U1);
plot(svd(U1),'*');
%     U1=U11(:,1:40);
%     plot(svd(U1),'*');
%
x2=ymF(:,labels==2);
U2=[];
for k=1:size(x2,2)
    H2=hankel_mo(x2(:,k)',[7*size(x2(:,k),2),size(x2,1)-7+1])';
    [U,S,V]=svd(H2);
    U2=[U2 U(:,1:7)];
end
[U21,S,V]=svd(U2);
plot(svd(U2),'*');
%     U2=U21(:,1:40);

x3=ymF(:,labels==3);
%     save dat328 x1 x2;
U3=[];
for k=1:size(x3,2)
    H3=hankel_mo(x3(:,k)',[7*size(x3(:,k),2),size(x3,1)-7+1])';
    [U,S,V]=svd(H3);
    U3=[U3 U(:,1:7)];
end
[U31,S31,V]=svd(U3);
plot(svd(U3),'*');
%     U3=U31(:,1:40);

x4=ymF(:,labels==4);
%     save dat328 x1 x2;
U4=[];
for k=1:size(x4,2)
    H4=hankel_mo(x4(:,k)',[7*size(x4(:,k),2),size(x4,1)-7+1])';
    [U,S,V]=svd(H4);
    U4=[U4 U(:,1:7)];
end
[U41,S41,V]=svd(U4);
plot(svd(U4),'*');
%     U4=U41(:,1:40);

angle12=subspace(U1,U2)
angle13=subspace(U1,U3)
angle14=subspace(U1,U4)
angle23=subspace(U2,U3)
angle24=subspace(U2,U4)
angle34=subspace(U3,U4)
for h1=1:40
    for h2=1:40
        hh(h1,h2)=h1+h2-getHankelRank([U31(:,1:h1) U21(:,1:h2)]);
        hh1(h1,h2)=min(h1,h2);
    end
end
hh2=hh-hh1;
[~,ind_hh2]=min(hh2(:));
[indr,indc]=ind2sub(size(hh2),ind_hh2)
%     keyboard;

%     for i=2:2
%
%         x2=ym(:,i);
%         x3=ymH(:,i+1);
%         x4=ymH(:,i+13*8);
%
%         H2=hankel_mo(x2',[j,length(x2)-j+1])';
%         H3=hankel_mo(x3',[j,length(x3)-j+1])';
%         H4=hankel_mo(x4',[j,length(x4)-j+1])';
%
%         [U2,S2,V2]=svd(H2);
%         [U3,S3,V3]=svd(H3);
%         [U4,S4,V4]=svd(H4);
%
%         angles1(i)=subspace(U1(:,1:10),U2(:,1:10));
%         angles2(i)=subspace(U1(:,1:10),U3(:,1:10));
%         angles3(i)=subspace(U1(:,1:10),U4(:,1:10));
%     end
%     angleNorms(j,:)=[norm(angles1,2) norm(angles2,2) norm(angles3,2)];
%     fprintf('rank %d processed\n',j);
%     % keyboard;
% end
% plot(angle23);
% % figure;
% hold on;
% plot(angleNorms(:,1),'b');
% plot(angleNorms(:,2),'g');
% plot(angleNorms(:,3),'m');
% hold off;
% % keyboard;
% % end
% keyboard;

%% Cross Validation

crossIdx=crossvalind('Kfold',size(ym,2),10);
order = 10;
HCount = 1;
HsizeRange = 10:133;
for Hsize=HsizeRange
    clear H U;
    for n=1:size(ym,2)
        H(:,:,n)=hankel_mo(ymH(:,n)',[Hsize,size(ym(:,n),1)-Hsize+1])';
        [U1,S1,V1]=svd(H(:,:,n));
        U(:,:,n)=U1(:,1:order);
    end
    
    
    fprintf('Hsize = %d\n',Hsize);
    GRlabels=[];
    TTlabels=[];
    tic
    for k=1:10
        fprintf('performing %d th of 10 experiments\n',k);
        % Training
        %         ytrain=ym(:,crossIdx~=k);
        Utrain=U(:,:,crossIdx~=k);
        trainLabels=labels(:,crossIdx~=k);
        Un1=[];
        Un2=[];
        Un3=[];
        Un4=[];
        for i=1:size(Utrain,3)
            switch trainLabels(i)
                case 1
                    Un1=[Un1 Utrain(:,:,i)];
                    
                case 2
                    Un2=[Un2 Utrain(:,:,i)];
                    
                case 3
                    Un3=[Un3 Utrain(:,:,i)];
                    
                case 4
                    Un4=[Un4 Utrain(:,:,i)];
                    
                otherwise
                    fprintf('error\n');
            end
        end
        [Up1 Sp1 Vp1]=svd(Un1);
        Uq1=Up1(:,1:22);
        [Up2 Sp2 Vp2]=svd(Un2);
        Uq2=Up2(:,1:22);
        [Up3 Sp3 Vp3]=svd(Un3);
        Uq3=Up3(:,1:22);
        [Up4 Sp4 Vp4]=svd(Un4);
        Uq4=Up4(:,1:22);
        %     parfor i=1:numLabels
        %         template(:,i)=mean(ytrain(:,trainLabels==i),2);
        %     end
        
        % Testing
        %         ytest=ym(1:266,crossIdx==k);
        Utest=U(:,:,crossIdx==k);
        testLabels=labels(crossIdx==k);
        lb=zeros(size(testLabels));
        %     Hsize = 40;
        
        for i=1:size(Utest,3)
            %fprintf('computing label of %d th test data of all %d \n',
            %             i,size(Utest,3));
            Ut=Utest(:,:,i);
            L=size(Utrain,3);
            
%             angles(1)=subspace(Ut,Uq1);
%             angles(2)=subspace(Ut,Uq2);
%             angles(3)=subspace(Ut,Uq3);
%             angles(4)=subspace(Ut,Uq4);
%             [Y,lb(i)]=min(angles);
            
            %             all_lb=[sum(angles(trainLabels==1))/sum(trainLabels==1)...
            %                 sum(angles(trainLabels==2))/sum(trainLabels==2)...
            %                 sum(angles(trainLabels==3))/sum(trainLabels==3)...
            %                 sum(angles(trainLabels==4))/sum(trainLabels==4)];
            %             [Y,lb(i)]=min(all_lb);
        end
        GRlabels=[GRlabels testLabels];
        TTlabels=[TTlabels lb];
    end
    toc
    %% Display results
    [GRlabels;TTlabels]
    precisionMat=zeros(numLabels);
    for j=1:numLabels
        for i=1:numLabels
            precisionMat(i,j)=nnz(TTlabels(GRlabels==j)==i)/nnz(GRlabels==j);
        end
    end
    P(:,:,HCount)=precisionMat;
    HCount=HCount+1;
end
% save bcidata_0328_L25_R5_H10__dat4_PrecisionMat P H U order HsizeRange;

% for ind=1:266
% ytest=data(ind+16662:ind+16662+266-1,2);
% d_all=sum((repmat(ytest,1,numLabels)-template).^2);
% [Y,I]=min(d_all);
% result(ind)=I;
% end
% result
% sum(result==3)