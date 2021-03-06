% ShowROCCurve

%test-label
testFile=importdata('test-label.txt');
label=testFile.data;
label(find(label==0))=-1;

%MBLBP
MBLBP=importdata('mblbp_score.txt');
[MBLBP_FAR, MBLBP_VR, ~, ~, ~] = CompROC( MBLBP, 1, label,10000 );

%CNN
CNN=importdata('cnn_score.txt');
CNN=CNN(:,2);
[CNN_FAR, CNN_VR, ~, ~, ~] = CompROC( CNN, 1, label,10000 );

%NPD
NPD=importdata('npd_score.txt');
[NPD_FAR, NPD_VR, ~, ~, ~] = CompROC( NPD, 1, label,10000 );

%Cascade-CNN
cas_cnn=importdata('cascade_score.txt');
cas_cnn=cas_cnn(:,2);
[cas_cnn_FAR, cas_cnn_VR, ~, ~, ~] = CompROC( cas_cnn, 1, label,10000 );

%LBP
LBP=importdata('lbp_score.txt');
[LBP_FAR, LBP_VR, ~, ~, ~] = CompROC( LBP, 1, label,10000 );

%LOMO
LOMO=importdata('lomo_score.txt');
[LOMO_FAR, LOMO_VR, ~, ~, ~] = CompROC( LOMO, 1, label,10000 );


semilogx(CNN_FAR,CNN_VR,'r','LineWidth',2); hold on;
semilogx(cas_cnn_FAR,cas_cnn_VR,'b','LineWidth',2); hold on;
semilogx(MBLBP_FAR,MBLBP_VR,'g','LineWidth',2); hold on;
semilogx(LOMO_FAR,LOMO_VR,'k','LineWidth',2); hold on;
semilogx(LBP_FAR,LBP_VR,'y','LineWidth',2); hold on;
semilogx(NPD_FAR,NPD_VR,'m','LineWidth',2); hold on;


% semilogx(LOMO_FAR,LOMO_VR,'c','LineWidth',2);

% legend('CNN','Cascade-CNN','MBLBP','LOMO','LBP','NPD',4);

grid minor;
xlabel('False Accept Rate');
ylabel('True Postive Rate');
title('ROC Curve in Detail');
xlim([0.0001 0.01]);
ylim([0 0.7]);

dlmwrite('NPD-far-vr.txt',[NPD_FAR,NPD_VR]);
dlmwrite('LOMO-far-vr.txt',[LOMO_FAR,LOMO_VR]);
dlmwrite('LBP-far-vr.txt',[LBP_FAR,LBP_VR]);
dlmwrite('MBLBP-far-vr.txt',[MBLBP_FAR,MBLBP_VR]);
dlmwrite('CNN-far-vr.txt',[CNN_FAR,CNN_VR]);
dlmwrite('cascade-far-vr.txt',[cas_cnn_FAR,cas_cnn_VR]);

%% pick pos and neg
% thresh=0.821;
% label(find(label==-1))=0;
% posInd=find(totalScore(:,2)<=thresh & label);
% 
% negInd=find(totalScore(:,1)>=thresh & ~label) ;
% 
% 
% pickNeg=testFile.textdata(negInd);
% pickPos=testFile.textdata(posInd);
% 
% fNeg=fopen('pick-neg.txt','w');
% fPos=fopen('pick-pos.txt','w');
% 
% for i=1:length(pickNeg)
%     fprintf(fNeg,'%s\n',pickNeg{i})
% end
% 
% for i=1:length(pickPos)
%     fprintf(fPick,'%s\n',pickPos{i});
% end
% 
% fclose(fPos);
% fclose(fNeg);