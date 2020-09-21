% Do not change the function name. You have to write your code here
% you have to submit this function
% Ahmad Ahmadirad Student ID 40055360
function segmentedImage = KMeans(featureImageIn, numberofClusters, clusterCentersIn)

% Get the dimensions of the input feature image
[M, N, noF] = size(featureImageIn);
% some initialization
% if no clusterCentersIn or it is empty, randomize the clusterCentersIn
% and run kmeans several times and keep the best one
if (nargin == 3) && (~isempty(clusterCentersIn))
    NofRadomization = 1;
else
    NofRadomization = 5;    % Should be greater than one
end


segmentedImage = zeros(M, N); %initialize. This will be the output

feature_vector=reshape(featureImageIn,M*N,noF);
Centers_Kmeans=cell(1,NofRadomization);
% run KMeans NofRadomization times
% ----------------------------------- % 
% -You have to write your code here-- %
% ----------------------------------- %

for KMeanNo = 1 : NofRadomization

    % randomize if clusterCentersIn was empty
    if NofRadomization>1
    
        clusterCentersIn = rand(numberofClusters, noF); %randomize initialization
    end
BestDfit = 1e12;  % Just a big number!

minD=0; %This is the minimum change in the distance that is required to repeat 
flag=0;
Iter_max=60;

cluster=clusterCentersIn;
class=zeros(1,M*N);
dist=zeros(M*N,numberofClusters);
Iter=1;

while flag<1 && Iter<Iter_max
    Iter=Iter+1;
    for i=1:(numberofClusters)
      % changing centers to repeated matrix to use matrix operation 
      % with matrix operation, loops are not used and the procedure speeds
      % up significantly

      cluster_matrix=repmat(clusterCentersIn(i,:),[M*N 1]);     
      % calculating the distance
      tmp=(feature_vector-cluster_matrix)';
      dist(:,i)=sqrt(sum(tmp.^2));
    end
    %choose the minimum distance of each cluster as the centroid  
[dis_min_all,class]=min(dist');
for k=1:numberofClusters
    if sum(class==k)>0
        % calculting the mean of data in each cluster
clusterCentersIn(k,:)=sum(feature_vector(class==k,:))./sum(class==k);
    else
  % if there is no feature in a centeroid, choose the center as random
clusterCentersIn(k,:)=rand(1, noF);
    end
end

if sum(dis_min_all)<BestDfit
BestDfit=sum(dis_min_all);
else
flag=1;
end
 dis_all(Iter-1)=sum(dis_min_all);
end
st1=strcat('Kmeans ',num2str(KMeanNo),' : Distance= ',num2str(BestDfit),'   Iter= ',num2str(Iter));
disp(st1)
disp('###################################################################')
Centers_Kmeans{KMeanNo}=clusterCentersIn;
dis_Random(KMeanNo)=BestDfit;
Ind_all{KMeanNo}=class;
end
[~,Center_Ind]=min(dis_Random);

Center_main=Centers_Kmeans{Center_Ind};

% claculating distance for each random repetition
class=Ind_all{Center_Ind};
segmentedImage=zeros(M,N);
% making segmentedImage
for q=1:M*N
    segmentedImage(q)=class(q);
end
   

    
    